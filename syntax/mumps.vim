" Mumps syntax file
" Language:	MUMPS
" Maintainer:	Jim Self, jaself@ucdavis.edu
" Last change:	02 June 2001

" related formatting, jas 24Sept03 - experimental
set lbr
set breakat=\ ,
set showbreak=\ \ \ \ \ \ \ +\ 

" Remove any old syntax stuff hanging around
syn clear
syn sync    maxlines=0
syn sync    minlines=0
syn case    ignore

"errors
syn match   mumpsError          contained /[^ \t;].\+/
syn match   mumpsBadString 	/".*/
" Catch mismatched parentheses
syn match   mumpsParenError	/).*/
syn match   mumpsBadParen	/(.*/


" Line Structure
syn region  mumpsComment        contained start=/;/ end=/$/
syn
" contains=mumpsTodo
syn region  mumpsTodo   	contained start=/TODO/ start=/XXX/ start=/FIX/ start=/DEBUG/ start=/DISABLED/ end=/;/ end=/$/

syn match   mumpsLabel  	contained /^[%A-Za-z][A-Za-z0-9]*\|^[0-9]\+/ nextgroup=mumpsFormalArgs
syn region  mumpsFormalArgs	contained oneline start=/(/ end=/)/ contains=mumpsLocalName,","
syn match   mumpsDotLevel	contained /\.[. \t]*/

syn region  mumpsCmd		contained oneline start=/[A-Za-z]/ end=/[ \t]/ end=/$/ contains=mumpsCommand,mumpsZCommand,mumpsPostCondition,mumpsError nextgroup=mumpsArgsSeg
syn region  mumpsPostCondition	contained oneline start=/:/hs=s+1 end=/[ \t]/re=e-1,he=e-1,me=e-1 end=/$/ contains=@mumpsExpr
syn region  mumpsArgsSeg	contained oneline start=/[ \t]/lc=1 end=/[ \t]\+/ end=/$/ contains=@mumpsExpr,",",mumpsPostCondition

syn match   mumpsLineStart      contained /^[ \t][. \t]*/ 
syn match   mumpsLineStart      contained /^[%A-Za-z][^ \t;]*[. \t]*/ contains=mumpsLabel,mumpsDotLevel 
syn region  mumpsLine		start=/^/ keepend end=/$/ contains=mumpsCmd,mumpsLineStart,mumpsComment

syn cluster mumpsExpr     	contains=mumpsVar,mumpsIntrinsic,mumpsExtrinsic,mumpsString,mumpsParen,mumpsOperator,mumpsBadString,mumpsBadNum,mumpsVRecord

syn match   mumpsVar		contained /\^=[%A-Za-z][A-Za-z0-9]*/ nextgroup=mumpsSubs
syn match   mumpsIntrinsic 	contained /$[%A-Za-z][A-Za-z0-9]*/ contains=mumpsIntrinsicFunc,mumpsZInFunc,mumpsSpecialVar,mumpsZVar nextgroup=mumpsParams
syn match   mumpsExtrinsic	contained /$$[%A-Za-z][A-Za-z0-9]*\(^[%A-Za-z][A-Za-z0-9]*\)\=/ nextgroup=mumpsParams

syn match   mumpsLocalName	contained /[%A-Za-z][A-Za-z0-9]*/

" Operators
syn match   mumpsOperator       contained "[+\-*/=&#!'\\\]<>?@]"
syn match   mumpsOperator       contained "]]"
syn region  mumpsVRecord	contained start=/[= \t,]</lc=1 end=/>/ contains=mumpsLocalName,","

" Constants
syn region  mumpsString 	contained oneline start=/"/ skip=/""/ excludenl end=/"/ oneline
syn match   mumpsBadNum 	contained /\<0\d+\>/
syn match   mumpsBadNum 	contained /\<\d*\.\d*0\>/
syn match   mumpsNumber 	contained /\<\d*\.\d{1,9}\>/
syn match   mumpsNumber 	contained /\<\d+\>/

syn region  mumpsParen     	contained oneline start=/(/ end=/)/ contains=@mumpsExpr
syn region  mumpsSubs		contained oneline start=/(/ end=/)/ contains=@mumpsExpr,","
syn region  mumpsActualArgs	contained oneline start=/(/ end=/)/ contains=@mumpsExpr,","

" Keyword definitions -------------------
"-- Commands --
syn keyword mumpsCommand	contained B[reak] C[lose] D[o] E[lse] F[or] G[oto] H[alt] H[ang]
syn keyword mumpsCommand 	contained I[f] J[ob] K[ill] L[ock] M[erge] N[ew] O[pen] Q[uit]
syn keyword mumpsCommand 	contained R[ead] S[et] TC[ommit] TRE[start] TRO[llback] TS[tart]
syn keyword mumpsCommand 	contained U[se] V[iew] W[rite] X[ecute] 

"  -- GT.M specific --
syn keyword mumpsZCommand 	contained ZA[llocate] ZB[reak] ZCOM[pile] ZC[ontinue] ZD[eallocate]
syn keyword mumpsZCommand 	contained ZED[it] ZG[oto] ZH[elp] ZL[ink] ZM[essage] ZP[rint]
syn keyword mumpsZCommand 	contained ZSH[ow] ZST[ep] ZSY[stem] ZTC[ommit] ZTS[tart]
syn keyword mumpsZCommand 	contained ZWI[thdraw] ZWR[ite]

"-- Intrinsic Functions
syn keyword mumpsIntrinsicFunc	contained A[scii] C[har] D[ata] E[xtract] F[ind] FN[umber] G[et]
syn keyword mumpsIntrinsicFunc	contained J[ustify] L[ength] N[ame] N[ext] O[rder] P[iece]
syn keyword mumpsIntrinsicFunc	contained Q[uery] R[andom] S[elect] T[ext] T[ranslate] V[iew]

" -- GT.M z-functions --
syn keyword mumpsZInFunc	contained ZD[ate] ZM[essage] ZPARSE ZP[revious] ZSEARCH ZTRNLNM 

" Special Variables
syn keyword mumpsSpecialVar	contained D[evice] H[orolog] I[O] J[ob] K[ey] P[rincipal]
syn keyword mumpsSpecialVar	contained S[torage] T[est] TL[evel] TR[estart] X Y	

"-- GT.M specific --
syn keyword mumpsZVar	contained ZCSTATUS ZDIR[ectory] ZEDIT ZEOF ZGBL[dir]
syn keyword mumpsZVar	contained ZIO ZL[evel] ZPOS[ition] ZPROMP[t] ZRO[utines]
syn keyword mumpsZVar	contained ZSO[urce] ZS[tatus] ZSYSTEM ZT[rap] ZVER[sion]

if !exists("did_mumps_syntax_inits")
  let did_mumps_syntax_inits = 1

  " The default methods for hilighting.  Can be overridden later
  hi! link mumpsCommand		Statement
  "hi! link mumpsZCommand        PreProc
  hi! link mumpsZCommand    Statement
  hi! link mumpsIntrinsicFunc   Function
  hi! link mumpsZInFunc		Preproc
  hi! link mumpsSpecialVar      Function
  hi! link mumpsZVar		PreProc
  hi! link mumpsLineStart    	Statement
  hi! link mumpsLabel		PreProc
  hi! link mumpsFormalArgs	PreProc
  hi! link mumpsDotLevel	PreProc
  hi! link mumpsCmdSeg		Special
  hi! link mumpsPostCondition	Special
  hi! link mumpsCmd		Statement
  hi! link mumpsArgsSeg		Special
  hi! link mumpsExpr		PreProc
  hi! link mumpsVar		Identifier
  hi! link mumpsParen           Special
  hi! link mumpsSubs            Special
  hi! link mumpsActualArgs      Special
  hi! link mumpsIntrinsic       Special
  hi! link mumpsExtrinsic	Special
  hi! link mumpsString		String
  hi! link mumpsNumber		Number
  hi! link mumpsOperator	Special
  hi! link mumpsComment		Error
  hi! link mumpsError		Error
  hi! link mumpsBadNum		Error
  hi! link mumpsBadString	Error
  hi! link mumpsBadParen	Error
  hi! link mumpsParenError	Error

  hi! link mumpsTodo		Todo
endif

let b:current_syntax = "mumps"

" vim: ts=8

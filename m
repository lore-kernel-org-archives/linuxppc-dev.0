Return-Path: <yigal_gold@yahoo.com>
Received: from web38905.mail.mud.yahoo.com (web38905.mail.mud.yahoo.com
	[209.191.125.111]) by ozlabs.org (Postfix) with SMTP id 82918DDDF6
	for <linuxppc-dev@ozlabs.org>; Mon,  6 Apr 2009 21:14:53 +1000 (EST)
Message-ID: <932829.65089.qm@web38905.mail.mud.yahoo.com>
Date: Mon, 6 Apr 2009 04:14:51 -0700 (PDT)
From: Yigal Goldberger <yigal_gold@yahoo.com>
Subject: making cuImage with ELDK 4.2
To: linuxppc-dev@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi all,
I'm trying to make cuImage using kernel 2.6.24.2 .
The problem is I can't find a match between a dtc version and a dts file that will compile . I took dtc-v1.2.0 from several sources and tried to make them . They all fail with the same error : 
	 CC dtc-lexer.lex.o
dtc-lexer.lex.c: In function `yylex':
dtc-lexer.lex.c:762: warning: label `find_rule' defined but not used
dtc-lexer.l: At top level:
dtc-lexer.lex.c:1870: warning: 'yy_flex_realloc' defined but not used
	 CC dtc-parser.tab.o
dtc-parser.tab.c: In function `yyparse':
dtc-parser.tab.c:1105: warning: implicit declaration of function `YYRHSLOC'
dtc-parser.tab.c:1105: error: request for member `first_line' in something not a structure or union
dtc-parser.tab.c:1105: error: request for member `first_column' in something not a structure or union
dtc-parser.tab.c:1105: error: request for member `last_line' in something not a structure or union
dtc-parser.tab.c:1105: error: request for member `last_column' in something not a structure or union
dtc-parser.tab.c:1105: error: request for member `file' in something not a structure or union
dtc-parser.tab.c:1105: error: request for member `last_line' in something not a structure or union
dtc-parser.tab.c:1105: error: request for member `last_column' in something not a structure or union
dtc-parser.tab.c:1105: error: request for member `file' in something not a structure or union
dtc-parser.tab.c:1625: error: request for member `first_line' in something not a structure or union
dtc-parser.tab.c:1625: error: request for member `first_column' in something not a structure or union
dtc-parser.tab.c:1625: error: request for member `last_line' in something not a structure or union
dtc-parser.tab.c:1625: error: request for member `last_column' in something not a structure or union
dtc-parser.tab.c:1625: error: request for member `file' in something not a structure or union
dtc-parser.tab.c:1625: error: request for member `last_line' in something not a structure or union
dtc-parser.tab.c:1625: error: request for member `last_column' in something not a structure or union
dtc-parser.tab.c:1625: error: request for member `file' in something not a structure or union
make: *** [dtc-parser.tab.o] Error 1

Does anyone have an Idea how to build the cuImage ?
If not , how to build the dtc ?

Thanks,
Yigal Goldberger.



      

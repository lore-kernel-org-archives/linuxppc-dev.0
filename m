Return-Path: <kriti.dutta@oracle.com>
Received: from agminet02.oracle.com (agminet02.oracle.com [141.146.126.229])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6011D68949
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Dec 2005 03:46:37 +1100 (EST)
Received: from agminet01.oracle.com (agminet01.oracle.com [141.146.126.228])
	by agminet02.oracle.com (Switch-3.1.7/Switch-3.1.7) with ESMTP id
	jBSEw6XL019642
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Dec 2005 08:58:06 -0600
Received: from rgmgw3.us.oracle.com (rgmgw3.us.oracle.com [138.1.186.112])
	by agminet01.oracle.com (Switch-3.1.7/Switch-3.1.7) with ESMTP id
	jBSEw0BA032221
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Dec 2005 08:58:01 -0600
Received: from rgmgw3.us.oracle.com (localhost [127.0.0.1])
	by rgmgw3.us.oracle.com (Switch-3.1.4/Switch-3.1.0) with ESMTP id
	jBSEw0Vi018217
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Dec 2005 07:58:00 -0700
Received: from kduttapc
	(dhcp-idc-lexington-towers-152-69-159-183.idc.oracle.com
	[152.69.159.183])
	by rgmgw3.us.oracle.com (Switch-3.1.4/Switch-3.1.0) with SMTP id
	jBSEvv8I018052
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Dec 2005 07:57:59 -0700
From: "Kriti Dutta" <kriti.dutta@oracle.com>
To: <linuxppc-dev@ozlabs.org>
Date: Wed, 28 Dec 2005 20:26:49 +0530
Message-ID: <GGEMIIODJPBLIOCGNLDJKEBJCAAA.kriti.dutta@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: XL C/C++ V7.0  Linux on POWER:Problem
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


 I encountered a compilation problem while building some C++ code that uses
the object space library (on Linux Power with
 the gcc 3.3.3and xlC 7.0 compiler). This library defines its own STL's &
iostream implementation, and it seems that it
 conflicts with the usage of the default standard iostream.The ERROR:

 "/usr/include/g++/backward/iostream.h", line 35.1: 1540-0400 (S) "ostream"
has a conflicting declaration.
 "/project/oracle/dc/src/dce/ol1/olstrm.h", line 83.7: 1540-0424 (I)
 "ostream" is declared on line 83 of
"/project/oracle/dc/src/dce/ol1/olstrm.h".

 "/project/oracle/dc/src/bin/ospace/Linux/ospace/std/iosfwd", line 24.10:
1540-0400 (S)
 "class istream" has a conflicting declaration.
 "/usr/include/g++/backward/iostream.h", line 36.1: 1540-0424 (I) "istream"
is declared on line 36 of
 /usr/include/g++/backward/iostream.h".

 "/project/oracle/dc/src/dce/ol1/ollogm.h", line 78.45: 1540-0063 (S)
 The text "ostrstream" is unexpected.

 "/project/oracle/dc/src/bin/ospace/Linux/ospace/osstd/list.h", line 572.7:
1540-0415 (S)
 "template <class T, class Allocator> class list" is already declared with
default template arguments.

 Are there any flags available to say the compiler that it should not use
the standard IO files.

 N.B: The same code has been compiled with gcc-2.95 on Linux & xlC-6.0 on
AIX without any issues.

 With regards
   Kriti.

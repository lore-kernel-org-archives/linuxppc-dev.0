Return-Path: <Tom.Bucken@sybase.com>
Received: from fm200.sybase.com (fm200.sybase.com [192.138.151.122])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "fm200.sybase.com", Issuer "fm200.sybase.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id C15C5DE04B
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Oct 2008 02:47:36 +1100 (EST)
To: linuxppc-dev@ozlabs.org
Subject: finding fuction names
MIME-Version: 1.0
Message-ID: <OFED6BB455.1624F375-ON852574E5.005284FE-852574E5.00530CF0@sybase.com>
From: Tom.Bucken@sybase.com
Date: Fri, 17 Oct 2008 11:07:11 -0400
Content-Type: multipart/alternative;
	boundary="=_alternative 00530CEE852574E5_="
Cc: vicknair@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multipart message in MIME format.
--=_alternative 00530CEE852574E5_=
Content-Type: text/plain; charset="US-ASCII"

/*

Hi,

   We have code in our product that produces stacktraces.  Part of the
implementation of this code runs nm to find all of the entry points in 
our libraries.

   Using the 7.0 version of this compiler to compile the simple code below

xlC_r -c -q64 tt.cxx 
 nm -C tt.o
                 U __IBMCPlusPlusExceptionV1
0000000000000000 D test()
0000000000000000 T .test()

   Using the 8.0 version of this compiler to compile the simple code below

xlC_r -c -q64 tt.cxx 
nm -C tt.o
                 U __IBMCPlusPlusExceptionV2
0000000000000000 D test()


    We grep the nm output for text symbols which are labeled with 'T'.
Not all function names are not labeled as text in objects compiled with 
8.0.
Is there another way to find all of the fuction names in a library or
a compiler switch that will put all fuctions into the text segment ?

thanks,

Tom

*/
 
int test()
{
  return 1;
}

--=_alternative 00530CEE852574E5_=
Content-Type: text/html; charset="US-ASCII"


<div>
<br><font size=2 face="sans-serif">/*</font>
<br>
<br><font size=2 face="sans-serif">Hi,</font>
<br>
<br><font size=2 face="sans-serif">&nbsp; &nbsp;We have code in our product
that produces stacktraces. &nbsp;Part of the<br>
implementation of this code runs nm to find all of the entry points in
<br>
our libraries.</font>
<br>
<br><font size=2 face="sans-serif">&nbsp; &nbsp;Using the 7.0 version of
this compiler to compile the simple code below</font>
<br>
<br><font size=2 face="sans-serif">xlC_r -c -q64 tt.cxx <br>
 nm -C tt.o<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; U __IBMCPlusPlusExceptionV1<br>
0000000000000000 D test()<br>
0000000000000000 T .test()</font>
<br>
<br><font size=2 face="sans-serif">&nbsp; &nbsp;Using the 8.0 version of
this compiler to compile the simple code below</font>
<br>
<br><font size=2 face="sans-serif">xlC_r -c -q64 tt.cxx <br>
nm -C tt.o<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; U __IBMCPlusPlusExceptionV2<br>
0000000000000000 D test()</font>
<br>
<br>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; We grep the nm output
for text symbols which are labeled with 'T'.<br>
Not all function names are not labeled as text in objects compiled with
8.0.<br>
Is there another way to find all of the fuction names in a library or<br>
a compiler switch that will put all fuctions into the text segment ?</font>
<br>
<br><font size=2 face="sans-serif">thanks,</font>
<br>
<br><font size=2 face="sans-serif">Tom</font>
<br>
<br><font size=2 face="sans-serif">*/<br>
 &nbsp;<br>
int test()<br>
{<br>
 &nbsp;return 1;<br>
}</font>
<br></div>
--=_alternative 00530CEE852574E5_=--

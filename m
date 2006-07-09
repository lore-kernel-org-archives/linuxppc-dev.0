Return-Path: <pheidius1@yahoo.com>
Received: from web35812.mail.mud.yahoo.com (web35812.mail.mud.yahoo.com
	[66.163.179.181]) by ozlabs.org (Postfix) with SMTP id EC970679E0
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Jul 2006 03:15:50 +1000 (EST)
Message-ID: <20060709170909.90774.qmail@web35812.mail.mud.yahoo.com>
Date: Sun, 9 Jul 2006 10:09:09 -0700 (PDT)
From: Paul Smith <pheidius1@yahoo.com>
Subject: setup arch
To: linuxppc-dev@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-526651294-1152464949=:87739"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--0-526651294-1152464949=:87739
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

I hesitate to lay this one out here because you all
are way over my head. The regular forums have not
responded to this in any meaningful way.
Hi, 


Box: 
Quad 2.5 PPC 
4.5 GB non ecc 533 Ram 
RocketRaid2320 
Nvida 6600 256mb 


software resources: 
install-ppc64-minimal-2006.0.iso 
install-ppc64-minimal-2006.0.iso.DIGESTS 
install-ppc64-minimal-2006.0.iso.CONTENTS 
install-ppc64-universal-2006.0-32ul.iso 
install-ppc64-universal-2006.0-32ul.iso.DIGESTS 
install-ppc64-universal-2006.0-32ul.iso.CONTENTS 

Checksum.app 



I am still stuck on this installation attempt. 
Here is a recap of the situation: 

Both the minimal .iso
images(install-ppc64-minimal-2006.0.iso) and the
universal.iso(install-ppc64-universal-2006.0-32ul.iso)have
been checksummed and check out good. 
I zereod out my cd media in both cases to make sure I
had no media damage that might cause corruption of the
images. 

When I boot from either the minimal or uninversal ppc
64 ect. ect. I get to a black screen that says: 

Welcome to the the Genntoo 2006 PPC install-CD. This
cd allows you to install on 64 bit apple and IBM
Hardware either a 32 or 64 bit user land, running on
top of a 64 bit kernal. Please refer to help on the cd
to learn more about this install-cd. 

Gentoo Installation Handbook http://ppc64.gentoo.org 
further info http;// ppc64gentoo.org 
Bugs: "bugs.gentoo.org(Cc ppc64@gentoo.org) 
IRC :#gentoo-ppc64 on IRC.freenode.net 
pesss tab to shoow the kernals. welcome to yaboot
version 1.3.11 
enter "help to get some basic usage information 

Boot: 

if I push enter it says "loading kernal" 
Elf64 ramdisk loaded 
(then something else real quick) 

then I hang in a grey screen that says 
Cf00100 
MM Init 
CF000012 
MM Init Done 
Cf000012 
Setup Arch 
The machine just hangs here with the fans running
pretty fast 

When I press tab the kernal that is available is: 

G5 G5-ttyS0,57600 

I know you are not really supposed to guess when you
are asking for help but the above is all the hard data
I know to give. 
I was looking at arch.app and it seems as if this is
the architecture part of the kernal. 
Given that this is very new hardware is it possible
that there is either a bug in the image or that this
hardware is not yet supported? 
Anyone have any ideas?


 		
---------------------------------
Want to be your own boss? Learn how on  Yahoo! Small Business. 
--0-526651294-1152464949=:87739
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

I hesitate to lay this one out here because you all<BR>are way over my head. The regular forums have not<BR>responded to this in any meaningful way.<BR>Hi, <BR><BR><BR>Box: <BR>Quad 2.5 PPC <BR>4.5 GB non ecc 533 Ram <BR>RocketRaid2320 <BR>Nvida 6600 256mb <BR><BR><BR>software resources: <BR>install-ppc64-minimal-2006.0.iso <BR>install-ppc64-minimal-2006.0.iso.DIGESTS <BR>install-ppc64-minimal-2006.0.iso.CONTENTS <BR>install-ppc64-universal-2006.0-32ul.iso <BR>install-ppc64-universal-2006.0-32ul.iso.DIGESTS <BR>install-ppc64-universal-2006.0-32ul.iso.CONTENTS <BR><BR>Checksum.app <BR><BR><BR><BR>I am still stuck on this installation attempt. <BR>Here is a recap of the situation: <BR><BR>Both the minimal .iso<BR>images(install-ppc64-minimal-2006.0.iso) and the<BR>universal.iso(install-ppc64-universal-2006.0-32ul.iso)have<BR>been checksummed and check out good. <BR>I zereod out my cd media in both cases to make sure I<BR>had no media damage that might cause corruption of
 the<BR>images. <BR><BR>When I boot from either the minimal or uninversal ppc<BR>64 ect. ect. I get to a black screen that says: <BR><BR>Welcome to the the Genntoo 2006 PPC install-CD. This<BR>cd allows you to install on 64 bit apple and IBM<BR>Hardware either a 32 or 64 bit user land, running on<BR>top of a 64 bit kernal. Please refer to help on the cd<BR>to learn more about this install-cd. <BR><BR>Gentoo Installation Handbook <A href="http://ppc64.gentoo.org/" target=_blank><FONT color=#003399>http://ppc64.gentoo.org </FONT></A><BR>further info http;// ppc64gentoo.org <BR>Bugs: "bugs.gentoo.org(Cc <A href="http://us.f358.mail.yahoo.com/ym/Compose?To=ppc64@gentoo.org&amp;YY=28308&amp;order=down&amp;sort=date&amp;pos=0&amp;view=a&amp;head=b"><FONT color=#003399>ppc64@gentoo.org</FONT></A>) <BR>IRC :#gentoo-ppc64 on IRC.freenode.net <BR>pesss tab to shoow the kernals. welcome to yaboot<BR>version 1.3.11 <BR>enter "help to get some basic usage information <BR><BR>Boot:
 <BR><BR>if I push enter it says "loading kernal" <BR>Elf64 ramdisk loaded <BR>(then something else real quick) <BR><BR>then I hang in a grey screen that says <BR>Cf00100 <BR>MM Init <BR>CF000012 <BR>MM Init Done <BR>Cf000012 <BR>Setup Arch <BR>The machine just hangs here with the fans running<BR>pretty fast <BR><BR>When I press tab the kernal that is available is: <BR><BR>G5 G5-ttyS0,57600 <BR><BR>I know you are not really supposed to guess when you<BR>are asking for help but the above is all the hard data<BR>I know to give. <BR>I was looking at arch.app and it seems as if this is<BR>the architecture part of the kernal. <BR>Given that this is very new hardware is it possible<BR>that there is either a bug in the image or that this<BR>hardware is not yet supported? <BR>Anyone have any ideas?<BR><BR><p>&#32;
		<hr size=1>Want to be your own boss? Learn how on <a href="http://us.rd.yahoo.com/evt=41244/*http://smallbusiness.yahoo.com/r-index"> Yahoo! Small Business.</a> 

--0-526651294-1152464949=:87739--

Return-Path: <paravpandit@yahoo.com>
Received: from web36604.mail.mud.yahoo.com (web36604.mail.mud.yahoo.com
	[209.191.85.21]) by ozlabs.org (Postfix) with SMTP id 30536679E7
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Aug 2006 22:58:44 +1000 (EST)
Message-ID: <20060824125843.36900.qmail@web36604.mail.mud.yahoo.com>
Date: Thu, 24 Aug 2006 05:58:43 -0700 (PDT)
From: Parav Pandit <paravpandit@yahoo.com>
Subject: Re: ARCH=ppc or ARCH=powerpc
To: Josh Boyer <jdub@us.ibm.com>
In-Reply-To: <1156423796.5640.23.camel@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1168018160-1156424323=:36492"
Cc: BDE@teamlog.com, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-1168018160-1156424323=:36492
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Thanks for correcting my understanding.
  We would also move our code to powerpc from ppc next release onwards.
   
  Parav
   
   
  
Josh Boyer <jdub@us.ibm.com> wrote:
  On Thu, 2006-08-24 at 05:38 -0700, Parav Pandit wrote:
> ppc = 32bit.
> powerpc= 64bit.
> Correct me if I am wrong.

Yes, you're wrong. Some 32 bit boards are also under arch/powerpc now.

> 
> I am not sure why community didn't adopt the name ppc and ppc64 just
> like ia-32 and ia64.

They did originally.

The new direction is to have everything under arch/powerpc, both 32 and
64 bit. The reason arch/ppc still exists is because some 32 bit
platforms have not been fully migrated to the requirements to be merged
into arch/powerpc. Namely, the code has to boot from an OpenFirmware
like flattened device tree. The PPC 4xx family of processors, as an
example, does not do this yet though there is work going on to adapt it.

Eventually, arch/ppc will go away and all of PowerPC will be under
arch/powerpc. That's the goal anyway.

josh




 		
---------------------------------
Stay in the know. Pulse on the new Yahoo.com.  Check it out. 
--0-1168018160-1156424323=:36492
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<div>Thanks for correcting my understanding.</div>  <div>We would also move our code to powerpc from ppc next release onwards.</div>  <div>&nbsp;</div>  <div>Parav</div>  <div>&nbsp;</div>  <div>&nbsp;</div>  <div><BR><B><I>Josh Boyer &lt;jdub@us.ibm.com&gt;</I></B> wrote:</div>  <BLOCKQUOTE class=replbq style="PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #1010ff 2px solid">On Thu, 2006-08-24 at 05:38 -0700, Parav Pandit wrote:<BR>&gt; ppc = 32bit.<BR>&gt; powerpc= 64bit.<BR>&gt; Correct me if I am wrong.<BR><BR>Yes, you're wrong. Some 32 bit boards are also under arch/powerpc now.<BR><BR>&gt; <BR>&gt; I am not sure why community didn't adopt the name ppc and ppc64 just<BR>&gt; like ia-32 and ia64.<BR><BR>They did originally.<BR><BR>The new direction is to have everything under arch/powerpc, both 32 and<BR>64 bit. The reason arch/ppc still exists is because some 32 bit<BR>platforms have not been fully migrated to the requirements to be merged<BR>into arch/powerpc.
 Namely, the code has to boot from an OpenFirmware<BR>like flattened device tree. The PPC 4xx family of processors, as an<BR>example, does not do this yet though there is work going on to adapt it.<BR><BR>Eventually, arch/ppc will go away and all of PowerPC will be under<BR>arch/powerpc. That's the goal anyway.<BR><BR>josh<BR><BR><BR></BLOCKQUOTE><BR><p>&#32;
		<hr size=1>Stay in the know. Pulse on the new Yahoo.com. <a href="http://us.rd.yahoo.com/evt=42974/*http://www.yahoo.com/preview"> Check it out.</a> 

--0-1168018160-1156424323=:36492--

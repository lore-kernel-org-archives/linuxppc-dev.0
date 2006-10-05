Return-Path: <pradeepsampath@yahoo.com>
Received: from web83212.mail.mud.yahoo.com (web83212.mail.mud.yahoo.com
	[216.252.101.68]) by ozlabs.org (Postfix) with SMTP id 4643967E35
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  6 Oct 2006 01:47:02 +1000 (EST)
Message-ID: <20061005154700.5018.qmail@web83212.mail.mud.yahoo.com>
Date: Thu, 5 Oct 2006 08:47:00 -0700 (PDT)
From: Pradeep Sampath <pradeepsampath@yahoo.com>
Subject: Re: booting 2.6 kernel on ML403
To: Ameet Patil <ammubhai@gmail.com>
In-Reply-To: <4524C290.3090702@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1796950396-1160063220=:97611"
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-1796950396-1160063220=:97611
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi Ameet,
   
  As soon as i apply the sysace driver and temac drivers and copy the xparameters_ml300.h (from EDK) to xparameters_ml403.h all i get is this... meaning kernel hangs after displaying "Now booting the kernel".
   
  When i disable sysace and TEMAC drivers, the system goes further till "root=" option and then tries to "Kernel Rebooting in 180 seconds". Yesterday i tried root=/dev/xsysace2 rw and creating block device files in /dev of the CF card. But it ran into the same problem.Is there a sysace driver patch that i can apply without applying the TEMAC driver patch? 
   
  So far i was using the EDK 8.1 SP2 (latest) which has the IP core TEMAC version 3.00. Now i downgraded to EDK 8.1 to get the version 2.00 (please see John Bonesio's post). 
   
  I thought the first step is to get the sysace driver running before applying the TEMAC drivers.

  thanks very much!
  Pradeep

Ameet Patil <ammubhai@gmail.com> wrote:
  Pradeep,
What you have pasted is only part of the messages displayed. I can't 
tell anything from this apart from you 'root=' option. It would be nice 
if you could paste the entire log of the boot messages right from 
'loaded at: xxxxxxx xxxxxxxx' to 'Kernel Rebooting in 150 seconds'.

-Ameet

Pradeep Sampath wrote:
> Ameet,
> 
> loaded at: 00400000 0051513C
> board data at: 00513124 0051313C
> relocated to: 004050E8 00405100
> zimage at: 004057FD 0051230A
> avail ram: 00516000 04000000
> Linux/PPC load: console=ttyS0,9600 root=/dev/xsa2
> Uncompressing Linux...done.
> Now booting the kernel
>
>
> Please could send me all the boot messages until the point where it
> stops. This will help me better identify the problem.
>
> Thanks,
> -Ameet
>
>



--0-1796950396-1160063220=:97611
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<div>Hi Ameet,</div>  <div>&nbsp;</div>  <div>As soon as i apply the sysace driver and temac drivers and copy the xparameters_ml300.h (from EDK) to xparameters_ml403.h all i get is this... meaning kernel hangs after displaying "Now booting the kernel".</div>  <div>&nbsp;</div>  <div>When i disable sysace and TEMAC drivers, the system goes further till "root=" option and then tries to "Kernel Rebooting in 180 seconds". Yesterday i tried root=/dev/xsysace2 rw and creating block device files in /dev of the CF card. But it&nbsp;ran into&nbsp;the same problem.Is there a sysace driver patch that i can apply without applying the TEMAC driver patch? </div>  <div>&nbsp;</div>  <div>So far i was using the EDK 8.1 SP2 (latest) which has the IP core TEMAC&nbsp;version 3.00. Now i downgraded to EDK 8.1&nbsp;to get the version&nbsp;2.00&nbsp;(please see John Bonesio's post). </div>  <div>&nbsp;</div>  <div>I thought the first step is to get the sysace driver running before applying the
 TEMAC drivers.<BR></div>  <div>thanks very much!</div>  <div>Pradeep<BR><BR><B><I>Ameet Patil &lt;ammubhai@gmail.com&gt;</I></B> wrote:</div>  <BLOCKQUOTE class=replbq style="PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #1010ff 2px solid">Pradeep,<BR>What you have pasted is only part of the messages displayed. I can't <BR>tell anything from this apart from you 'root=' option. It would be nice <BR>if you could paste the entire log of the boot messages right from <BR>'loaded at: xxxxxxx xxxxxxxx' to 'Kernel Rebooting in 150 seconds'.<BR><BR>-Ameet<BR><BR>Pradeep Sampath wrote:<BR>&gt; Ameet,<BR>&gt; <BR>&gt; loaded at: 00400000 0051513C<BR>&gt; board data at: 00513124 0051313C<BR>&gt; relocated to: 004050E8 00405100<BR>&gt; zimage at: 004057FD 0051230A<BR>&gt; avail ram: 00516000 04000000<BR>&gt; Linux/PPC load: console=ttyS0,9600 root=/dev/xsa2<BR>&gt; Uncompressing Linux...done.<BR>&gt; Now booting the kernel<BR>&gt;<BR>&gt;<BR>&gt; Please could send me all the boot
 messages until the point where it<BR>&gt; stops. This will help me better identify the problem.<BR>&gt;<BR>&gt; Thanks,<BR>&gt; -Ameet<BR>&gt;<BR>&gt;<BR><BR></BLOCKQUOTE><BR>
--0-1796950396-1160063220=:97611--

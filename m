Return-Path: <cristian.axenie@gmail.com>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.158])
	by ozlabs.org (Postfix) with ESMTP id EDF3DDDD0B
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 15 Nov 2008 20:12:51 +1100 (EST)
Received: by fg-out-1718.google.com with SMTP id d23so1437276fga.39
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 15 Nov 2008 01:12:49 -0800 (PST)
Message-ID: <9c789a000811150112i484baa39y846bbf38ed6e1bb8@mail.gmail.com>
Date: Sat, 15 Nov 2008 11:12:49 +0200
From: "Cristian Axenie" <cristian.axenie@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: USB Flash rootfs prep!
In-Reply-To: <9c789a000811150112q3088a044ub8b38489b2119a60@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_16623_3660295.1226740369280"
References: <9c789a000811141705k245e4447k8a9be8e4f180c3f8@mail.gmail.com>
	<1226737139.17218.14.camel@md40100b.ft>
	<9c789a000811150112q3088a044ub8b38489b2119a60@mail.gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_16623_3660295.1226740369280
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Sat, Nov 15, 2008 at 11:12 AM, Cristian Axenie <cristian.axenie@gmail.com
> wrote:

>
>
> On Sat, Nov 15, 2008 at 10:18 AM, Joachim Foerster <mls.JOFT@gmx.de>wrote:
>
>> Hi Cristian,
>>
>> On Sat, 2008-11-15 at 03:05 +0200, Cristian Axenie wrote:
>> > VFS: Mounted root (ext2 filesystem) readonly.
>> > Freeing unused kernel memory: 156k init
>> > Warning: unable to open an initial console.
>>
>> Device file /dev/console doesn't seem to exist in your rootfs.
>
> Strange because /dev/console exists in my ext2.img.
>
>>
>>
>> > Failed to execute /bin/busybox.  Attempting defaults...
>> > Kernel panic - not syncing: No init found.  Try passing init= option
>> > to kernel.
>>
>> It seems that you don't have an executable called /bin/busybox in your
>> rootfs. Your kernel command line seems to have "init=/bin/busybox"
>> included?
>>
>> But, hmmm, it is very strange, at least in your uboot bootargs there is
>> no such string. Is it because of some default kernel command line (set
>> before compiling the kernel)?
>
>
> I simply forgot to write them here (because I didn't knew if they were
> valid) but I 've tried with init=/sbin/init and get the same result !
>
>>
>>
>> > Rebooting in 180 seconds..
>> >
>> > Shall I explicitly give the init ? What should be ... init=/sbin/init,
>> > init=/bin/busybox ????
>>
>> The rootfs which comes with ELDK "starts" with /sbin/init - it does not
>> use busybox, right (as far as I can remember)? So you need to specify
>> "init=/sbin/init" on your kernel command line.
>
>
> I've tried with /sbin/init and the same !!
>
>>
>>
>>  Joachim
>>
>>
>>
> Cristian
>

------=_Part_16623_3660295.1226740369280
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><br><div class="gmail_quote">On Sat, Nov 15, 2008 at 11:12 AM, Cristian Axenie <span dir="ltr">&lt;<a href="mailto:cristian.axenie@gmail.com">cristian.axenie@gmail.com</a>&gt;</span> wrote:<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<br><br><div class="gmail_quote"><div class="Ih2E3d">On Sat, Nov 15, 2008 at 10:18 AM, Joachim Foerster <span dir="ltr">&lt;<a href="mailto:mls.JOFT@gmx.de" target="_blank">mls.JOFT@gmx.de</a>&gt;</span> wrote:<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">

Hi Cristian,<br>
<div><br>
On Sat, 2008-11-15 at 03:05 +0200, Cristian Axenie wrote:<br>
&gt; VFS: Mounted root (ext2 filesystem) readonly.<br>
&gt; Freeing unused kernel memory: 156k init<br>
&gt; Warning: unable to open an initial console.<br>
<br>
</div>Device file /dev/console doesn&#39;t seem to exist in your rootfs.</blockquote></div><div>Strange because /dev/console exists in my ext2.img. <br></div><div class="Ih2E3d"><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">

<br>
<div><br>
&gt; Failed to execute /bin/busybox. &nbsp;Attempting defaults...<br>
&gt; Kernel panic - not syncing: No init found. &nbsp;Try passing init= option<br>
&gt; to kernel.<br>
<br>
</div>It seems that you don&#39;t have an executable called /bin/busybox in your<br>
rootfs. Your kernel command line seems to have &quot;init=/bin/busybox&quot;<br>
included?<br>
<br>
But, hmmm, it is very strange, at least in your uboot bootargs there is<br>
no such string. Is it because of some default kernel command line (set<br>
before compiling the kernel)?</blockquote></div><div><br>I simply forgot to write them here (because I didn&#39;t knew if they were valid) but I &#39;ve tried with init=/sbin/init and get the same result !<br></div><div class="Ih2E3d">
<blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<br>
<div><br>
&gt; Rebooting in 180 seconds..<br>
&gt;<br>
&gt; Shall I explicitly give the init ? What should be ... init=/sbin/init,<br>
&gt; init=/bin/busybox ????<br>
<br>
</div>The rootfs which comes with ELDK &quot;starts&quot; with /sbin/init - it does not<br>
use busybox, right (as far as I can remember)? So you need to specify<br>
&quot;init=/sbin/init&quot; on your kernel command line.</blockquote></div><div><br>I&#39;ve tried with /sbin/init and the same !! <br></div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">

<br>
<font color="#888888"><br>
&nbsp;Joachim<br>
<br>
<br>
</font></blockquote></div><br>Cristian <br>
</blockquote></div><br>

------=_Part_16623_3660295.1226740369280--

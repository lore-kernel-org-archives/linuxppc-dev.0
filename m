Return-Path: <satyakiran@gmail.com>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.153])
	by ozlabs.org (Postfix) with ESMTP id 174D6DDDEC
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Oct 2008 09:50:32 +1100 (EST)
Received: by fg-out-1718.google.com with SMTP id d23so94334fga.39
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Oct 2008 15:50:31 -0700 (PDT)
Message-ID: <acbcf3840810211550q34dac858je6c114a924067d65@mail.gmail.com>
Date: Tue, 21 Oct 2008 15:50:30 -0700
From: Satya <satyakiran@gmail.com>
To: benh@kernel.crashing.org
Subject: Re: hugetlbfs for ppc440 - kernel BUG
In-Reply-To: <acbcf3840810211546s1d72dac0kabcf1285358efbdf@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_14642_15712182.1224629430993"
References: <acbcf3840707101138t24597799s6511f9326ed2243e@mail.gmail.com>
	<1224622063.7654.265.camel@pasglop>
	<acbcf3840810211546s1d72dac0kabcf1285358efbdf@mail.gmail.com>
Cc: kazutomo@mcs.anl.gov, linuxppc-dev@ozlabs.org, edi@linux.vnet.ibm.com,
	david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_14642_15712182.1224629430993
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tue, Oct 21, 2008 at 3:46 PM, Satya <satyakiran@gmail.com> wrote:

> Ben,
> Look here: http://www-unix.mcs.anl.gov/zeptoos/hugepages/
>
> thanks,
> ./satya
>
>
> On Tue, Oct 21, 2008 at 1:47 PM, Benjamin Herrenschmidt <
> benh@kernel.crashing.org> wrote:
>
>> On Tue, 2007-07-10 at 13:38 -0500, Satya wrote:
>> > hello,
>> > I am trying to implement hugetlbfs on the IBM Bluegene/L IO node
>> > (ppc440) and I have a big problem as well as a few questions to ask
>> > the group. I patched a 2.6.21.6 linux kernel (manually) with Edi
>> > Shmueli's hugetlbfs implementation (found here:
>> > http://patchwork.ozlabs.org/linuxppc/patch?id=8427) for this. I did
>> > have to make slight changes (described at the end) to make it work.
>> > My test program is a shortened version of a sys v shared memory
>> > example described in Documentation/vm/hugetlbpage.txt
>>
>> Hi !
>>
>> The patchwork link unfortunately didn't survive the transition to
>> patchwork 2.
>>
>> Do you know what's the status of Hugetlb support for 44x ? Is there any
>> plan to release that for upstream inclusion ?
>>
>> Cheers,
>> Ben.
>>
>>
>>

whoops, sorry for top-posting. Here is a patch that worked at that time:
http://www-unix.mcs.anl.gov/zeptoos/hugepages/hugetlbpage_44x.patch

I didn't follow up after this to get it merged upstream. Also I don't know
if hugetlb core has changed to deal with PTEs in high memory.

./satya

------=_Part_14642_15712182.1224629430993
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><br><div class="gmail_quote">On Tue, Oct 21, 2008 at 3:46 PM, Satya <span dir="ltr">&lt;<a href="mailto:satyakiran@gmail.com">satyakiran@gmail.com</a>&gt;</span> wrote:<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Ben,<br>Look here: <a href="http://www-unix.mcs.anl.gov/zeptoos/hugepages/" target="_blank">http://www-unix.mcs.anl.gov/zeptoos/hugepages/</a><br><br>thanks,<br><font color="#888888">./satya</font><div><div></div><div class="Wj3C7c">
<br><br><div class="gmail_quote">On Tue, Oct 21, 2008 at 1:47 PM, Benjamin Herrenschmidt <span dir="ltr">&lt;<a href="mailto:benh@kernel.crashing.org" target="_blank">benh@kernel.crashing.org</a>&gt;</span> wrote:<br>
<blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div>On Tue, 2007-07-10 at 13:38 -0500, Satya wrote:<br>
&gt; hello,<br>
&gt; I am trying to implement hugetlbfs on the IBM Bluegene/L IO node<br>
&gt; (ppc440) and I have a big problem as well as a few questions to ask<br>
&gt; the group. I patched a <a href="http://2.6.21.6" target="_blank">2.6.21.6</a> linux kernel (manually) with Edi<br>
&gt; Shmueli&#39;s hugetlbfs implementation (found here:<br>
&gt; <a href="http://patchwork.ozlabs.org/linuxppc/patch?id=8427" target="_blank">http://patchwork.ozlabs.org/linuxppc/patch?id=8427</a>) for this. I did<br>
&gt; have to make slight changes (described at the end) to make it work.<br>
&gt; My test program is a shortened version of a sys v shared memory<br>
&gt; example described in Documentation/vm/hugetlbpage.txt<br>
<br>
</div>Hi !<br>
<br>
The patchwork link unfortunately didn&#39;t survive the transition to<br>
patchwork 2.<br>
<br>
Do you know what&#39;s the status of Hugetlb support for 44x ? Is there any<br>
plan to release that for upstream inclusion ?<br>
<br>
Cheers,<br>
Ben.<br>
<br>
<br>
</blockquote></div></div></div></blockquote><div><br>&nbsp;</div></div>whoops, sorry for top-posting. Here is a patch that worked at that time:<br><a href="http://www-unix.mcs.anl.gov/zeptoos/hugepages/hugetlbpage_44x.patch">http://www-unix.mcs.anl.gov/zeptoos/hugepages/hugetlbpage_44x.patch</a><br>
<br>I didn&#39;t follow up after this to get it merged upstream. Also I don&#39;t know if hugetlb core has changed to deal with PTEs in high memory.<br><br>./satya<br>

------=_Part_14642_15712182.1224629430993--

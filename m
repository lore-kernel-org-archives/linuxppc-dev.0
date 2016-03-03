Return-Path: <bsingharora@gmail.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8E1101A0B50
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Mar 2016 07:43:58 +1100 (AEDT)
Received: from mail-yk0-x22e.google.com (mail-yk0-x22e.google.com
 [IPv6:2607:f8b0:4002:c07::22e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id DEAB5141BA5
 for <linuxppc-dev@ozlabs.org>; Fri,  4 Mar 2016 07:43:57 +1100 (AEDT)
Received: by mail-yk0-x22e.google.com with SMTP id v186so14524616yke.2
 for <linuxppc-dev@ozlabs.org>; Thu, 03 Mar 2016 12:43:57 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1457023921-2051-1-git-send-email-pmladek@suse.com>
References: <1457023921-2051-1-git-send-email-pmladek@suse.com>
Date: Fri, 4 Mar 2016 07:43:55 +1100
Message-ID: <CAKTCnzmtnkqcgSHu0YFpzxP3Rcdsb4KTDmd8uBDwW4MZ0ACbxQ@mail.gmail.com>
Subject: Re: [PATCH][v4] livepatch/ppc: Enable livepatching on powerpc
From: Balbir Singh <bsingharora@gmail.com>
To: Petr Mladek <pmladek@suse.com>
Cc: linuxppc-dev@ozlabs.org, Miroslav Benes <mbenes@suse.cz>,
 Torsten Duwe <duwe@suse.de>, duwe@lst.de,
 live-patching@vger.kernel.org, jkosina@suse.cz, rostedt@goodmis.org,
 jeyu@redhat.com, kamalesh@linux.vnet.ibm.com, linux-kernel@vger.kernel.org
Content-Type: multipart/alternative; boundary=001a1142371ca207f3052d2b0e3e
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--001a1142371ca207f3052d2b0e3e
Content-Type: text/plain; charset=UTF-8

On 4 Mar 2016 03:52, "Petr Mladek" <pmladek@suse.com> wrote:
>
> From: Balbir Singh <bsingharora@gmail.com>
>
> Changelog v4:
>         1. Renamed klp_matchaddr() to klp_get_ftrace_location()
>            and used it just to convert the function address.
>         2. Synced klp_write_module_reloc() with s390(); made it
>            inline, no error message, return -ENOSYS
>         3. Added an error message when including
>            powerpc/include/asm/livepatch.h without HAVE_LIVEPATCH
>         4. Update some comments.
> Changelog v3:
>         1. Moved -ENOSYS to -EINVAL in klp_write_module_reloc
>         2. Moved klp_matchaddr to use ftrace_location_range
> Changelog v2:
>         1. Implement review comments by Michael
>         2. The previous version compared _NIP from the
>            wrong location to check for whether we
>            are going to a patched location
>
> This applies on top of the patches posted by Michael
> https://patchwork.ozlabs.org/patch/589791/
>
> It enables livepatching. This takes patch 6/8 and 7/8 of v8 as the base.
> (See the reference [1] below) and adds logic for checking offset ranges
> in livepatch with ftrace_location_range.
>
> I tested the sample in the livepatch
>
> Signed-off-by: Torsten Duwe <duwe@suse.de>
> Signed-off-by: Balbir Singh <bsingharora@gmail.com>
> Signed-off-by: Petr Mladek <pmladek@suse.com>
>
Like the cleanup and the patch

Balbir

--001a1142371ca207f3052d2b0e3e
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"><br>
On 4 Mar 2016 03:52, &quot;Petr Mladek&quot; &lt;<a href=3D"mailto:pmladek@=
suse.com">pmladek@suse.com</a>&gt; wrote:<br>
&gt;<br>
&gt; From: Balbir Singh &lt;<a href=3D"mailto:bsingharora@gmail.com">bsingh=
arora@gmail.com</a>&gt;<br>
&gt;<br>
&gt; Changelog v4:<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 1. Renamed klp_matchaddr() to klp_get_ftra=
ce_location()<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0and used it just to convert t=
he function address.<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 2. Synced klp_write_module_reloc() with s3=
90(); made it<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0inline, no error message, ret=
urn -ENOSYS<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 3. Added an error message when including<b=
r>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0powerpc/include/asm/livepatch=
.h without HAVE_LIVEPATCH<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 4. Update some comments.<br>
&gt; Changelog v3:<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 1. Moved -ENOSYS to -EINVAL in klp_write_m=
odule_reloc<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 2. Moved klp_matchaddr to use ftrace_locat=
ion_range<br>
&gt; Changelog v2:<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 1. Implement review comments by Michael<br=
>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 2. The previous version compared _NIP from=
 the<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0wrong location to check for w=
hether we<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0are going to a patched locati=
on<br>
&gt;<br>
&gt; This applies on top of the patches posted by Michael<br>
&gt; <a href=3D"https://patchwork.ozlabs.org/patch/589791/">https://patchwo=
rk.ozlabs.org/patch/589791/</a><br>
&gt;<br>
&gt; It enables livepatching. This takes patch 6/8 and 7/8 of v8 as the bas=
e.<br>
&gt; (See the reference [1] below) and adds logic for checking offset range=
s<br>
&gt; in livepatch with ftrace_location_range.<br>
&gt;<br>
&gt; I tested the sample in the livepatch<br>
&gt;<br>
&gt; Signed-off-by: Torsten Duwe &lt;<a href=3D"mailto:duwe@suse.de">duwe@s=
use.de</a>&gt;<br>
&gt; Signed-off-by: Balbir Singh &lt;<a href=3D"mailto:bsingharora@gmail.co=
m">bsingharora@gmail.com</a>&gt;<br>
&gt; Signed-off-by: Petr Mladek &lt;<a href=3D"mailto:pmladek@suse.com">pml=
adek@suse.com</a>&gt;<br>
&gt;<br>
Like the cleanup and the patch</p>
<p dir=3D"ltr">Balbir<br>
</p>

--001a1142371ca207f3052d2b0e3e--

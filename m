Return-Path: <xiyou.wangcong@gmail.com>
Received: from mail-pz0-f42.google.com (mail-pz0-f42.google.com
	[209.85.210.42]) by ozlabs.org (Postfix) with ESMTP id ECE8EB6F07
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Jul 2010 19:13:26 +1000 (EST)
Received: by pzk30 with SMTP id 30so2129105pzk.15
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Jul 2010 02:13:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20100726152315.GA18789@hmsreliant.think-freely.org>
References: <20100713134609.GA14514@hmsreliant.think-freely.org>
	<20100726152315.GA18789@hmsreliant.think-freely.org>
Date: Tue, 27 Jul 2010 17:13:24 +0800
Message-ID: <AANLkTimx4=y4DgreWJOQ2=y4CmMm1p7bku=UJtsXXss3@mail.gmail.com>
Subject: Re: [PATCH] powerpc: Add vmcoreinfo symbols to allow makdumpfile to
	filter core files properly
From: =?UTF-8?Q?Am=C3=A9rico_Wang?= <xiyou.wangcong@gmail.com>
To: Neil Horman <nhorman@tuxdriver.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, paulus@samba.org, vgoyal@redhat.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jul 26, 2010 at 11:23 PM, Neil Horman <nhorman@tuxdriver.com> wrote=
:
> On Tue, Jul 13, 2010 at 09:46:09AM -0400, Neil Horman wrote:
>> Hey all-
>> =C2=A0 =C2=A0 =C2=A0 About 2 years ago now, I sent this patch upstream t=
o allow makedumpfile
>> to properly filter cores on ppc64:
>> http://www.mail-archive.com/kexec@lists.infradead.org/msg02426.html
>> It got acks from the kexec folks so I pulled it into RHEL, but I never c=
hecked
>> back here to make sure it ever made it in, which apparently it didn't. =
=C2=A0It still
>> needs to be included, so I'm reposting it here, making sure to copy all =
the ppc
>> folks this time. =C2=A0I've retested it on the latest linus kernel and i=
t works fine,
>> allowing makedumpfile to find all the symbols it needs to properly strip=
 a
>> vmcore on ppc64.
>>
>> Neil
>>
>> Signed-off-by: Neil Horman <nhorman@tuxdriver.com>
>>
> Ping, anyone want to chime in on this, its needed for dump filtering to w=
ork
> properly on ppc64

This patch looks good for me.

Reviewed-by: WANG Cong <xiyou.wangcong@gmail.com>

Thanks!

Return-Path: <jwboyer@gmail.com>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
 [209.85.212.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id BA00DB6F18
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Nov 2011 22:45:40 +1100 (EST)
Received: by vbbfp1 with SMTP id fp1so247949vbb.38
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Nov 2011 03:45:37 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1322632107.21641.43.camel@pasglop>
References: <1322630640-13708-1-git-send-email-tony@bakeyournoodle.com>
 <1322630640-13708-5-git-send-email-tony@bakeyournoodle.com>
 <1322632107.21641.43.camel@pasglop>
Date: Wed, 30 Nov 2011 06:45:37 -0500
Message-ID: <CA+5PVA6kBquh2=sPy25PKGSMBWvoZFFvZjrL4bgdmddFgjyaQA@mail.gmail.com>
Subject: Re: [PATCH 4/6] powerpc/boot: Add extended precision shifts to the
 boot wrapper.
From: Josh Boyer <jwboyer@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: LinuxPPC-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Nov 30, 2011 at 12:48 AM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Wed, 2011-11-30 at 16:23 +1100, Tony Breeds wrote:
>> Code copied from arch/powerpc/kernel/misc_32.S
>>
>> Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>
>> ---
>> =A0arch/powerpc/boot/div64.S | =A0 52 ++++++++++++++++++++++++++++++++++=
+++++++++++
>> =A01 files changed, 52 insertions(+), 0 deletions(-)
>
> Should we just link with libgcc ? :-)

Please tell me you're joking.

However, adding this code and wonderful and all but why do we need to
add it?  Changelog should say why.

josh

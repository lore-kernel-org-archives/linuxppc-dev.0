Return-Path: <jwboyer@gmail.com>
Received: from mail-ww0-f45.google.com (mail-ww0-f45.google.com [74.125.82.45])
	by ozlabs.org (Postfix) with ESMTP id 30878B6F11
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  1 Oct 2010 21:27:39 +1000 (EST)
Received: by wwa36 with SMTP id 36so2765926wwa.14
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 01 Oct 2010 04:27:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1285916771-18033-6-git-send-email-imunsie@au1.ibm.com>
References: <1285916771-18033-1-git-send-email-imunsie@au1.ibm.com>
	<1285916771-18033-6-git-send-email-imunsie@au1.ibm.com>
Date: Fri, 1 Oct 2010 07:27:37 -0400
Message-ID: <AANLkTins34TrEWj618_4XBRwGGFqRSehwWEp7jBubvsu@mail.gmail.com>
Subject: Re: [PATCH 05/18] powerpc: Wire up 44x little endian boot for
	remaining 44x targets
From: Josh Boyer <jwboyer@gmail.com>
To: Ian Munsie <imunsie@au1.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Oct 1, 2010 at 3:05 AM, Ian Munsie <imunsie@au1.ibm.com> wrote:
> From: Ian Munsie <imunsie@au1.ibm.com>
>
> I haven't tested booting a little endian kernel on any of these targets,
> but they all claim to be 44x so my little endian trampoline should work
> on all of them, so wire it up on:
>
> bamboo
> katmai
> kilauea
> rainer
> sam440ep
> sequoia
> warp
> yosemite
> ebony
>
> Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>

I see no reason to do this at all.  If you haven't tested them and
there is no demand, there's no reason to wire them up.  Some might
actively want to disallow LE mode anyway, like the Warp or Sam440EP.

josh

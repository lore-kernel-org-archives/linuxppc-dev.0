Return-Path: <stephane.marchesin@gmail.com>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.227])
	by ozlabs.org (Postfix) with ESMTP id 2723CDDE49
	for <linuxppc-dev@ozlabs.org>; Mon,  3 Mar 2008 05:48:48 +1100 (EST)
Received: by wr-out-0506.google.com with SMTP id 67so1184374wri.3
	for <linuxppc-dev@ozlabs.org>; Sun, 02 Mar 2008 10:48:47 -0800 (PST)
Message-ID: <6a89f9d50803021048v7a330bd6m82d553d80042c5aa@mail.gmail.com>
Date: Sun, 2 Mar 2008 19:48:45 +0100
From: "Stephane Marchesin" <marchesin@icps.u-strasbg.fr>
Sender: stephane.marchesin@gmail.com
To: linuxppc-dev@ozlabs.org, "David Woodhouse" <dwmw2@infradead.org>,
	benh@kernel.crashing.org, paulus@samba.org,
	henrik.sorensen@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: V4L2: __ucmpdi2 undefined on ppc
In-Reply-To: <6a89f9d50802060639j4b3a8b7u4e4e596b010ee353@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <Pine.SOC.4.61.0612131359430.10721@math.ut.ee>
	<1166053317.909.19.camel@praia>
	<20061214195842.GA14041@athena.road.mcmartin.ca>
	<1166362145.6714.53.camel@pmac.infradead.org>
	<6a89f9d50802060639j4b3a8b7u4e4e596b010ee353@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 2/6/08, Stephane Marchesin <marchesin@icps.u-strasbg.fr> wrote:
>
>  We're hitting this i nouveau as well (http://nouveau.freedesktop.org),
>  since we make extensive use ot 64 bit ints. Over time, we've had a
>  number of reports on this issue, and at one point I read that it
>  should be fixed in gcc. But recently, a nouveau user on PPC32 (Henrik
>  in CC:) reported the issue again with gcc 4.2.3. Others have it on gcc
>  4.2.2 too:
>  http://bugs.freedesktop.org/show_bug.cgi?id=10547
>
>  So, the point of this email is to ask about the possibility of merging
>  in one of the __ucmpdi2 patches, like David's which is kept below for
>  reference. Most distros seem to ship with such a patch already, and it
>  seems that other drivers hit this as well.
>

So, could we have that thing in main tree ? It's not like it's
untested, most distros carry that, and a couple of arches provide
their own ucmpdi2 implementation already. It's also such a small
function...

Stephane

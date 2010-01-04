Return-Path: <glikely@secretlab.ca>
Received: from mail-yx0-f181.google.com (mail-yx0-f181.google.com
	[209.85.210.181]) by ozlabs.org (Postfix) with ESMTP id 7B2CBB6EF6
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Jan 2010 19:34:53 +1100 (EST)
Received: by yxe11 with SMTP id 11so12463181yxe.15
	for <linuxppc-dev@ozlabs.org>; Mon, 04 Jan 2010 00:34:52 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <87skanp8ln.fsf@macbook.be.48ers.dk>
References: <1261446643-21714-1-git-send-email-ptyser@xes-inc.com>
	<1261446643-21714-4-git-send-email-ptyser@xes-inc.com>
	<fa686aa40912301502x48785614ya4dd5c71815a7633@mail.gmail.com>
	<20091231224439.AF5353F6D1@gemini.denx.de>
	<1262301038.29396.137.camel@localhost.localdomain>
	<20100101104449.6DAC63F6FF@gemini.denx.de>
	<87wrzzpq8c.fsf@macbook.be.48ers.dk>
	<20100103095032.8F05AE34A26@gemini.denx.de>
	<87skanp8ln.fsf@macbook.be.48ers.dk>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 4 Jan 2010 01:34:32 -0700
Message-ID: <fa686aa41001040034i22703ab5s6ac0e1fc8ff6b000@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] powerpc: Add support for ram filesystems in FIT
	uImages
To: Peter Korsgaard <jacmet@sunsite.dk>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Peter Tyser <ptyser@xes-inc.com>,
	Wolfgang Denk <wd@denx.de>, linux-kbuild@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Jan 3, 2010 at 7:27 AM, Peter Korsgaard <jacmet@sunsite.dk> wrote:
>>>>>> "Wolfgang" =3D=3D Wolfgang Denk <wd@denx.de> writes:
>
> Hi,
>
> =A0>> No, that would break stuff for the existing users. The existing for=
mat
> =A0>> make/file names shouldn't change.
>
> =A0Wolfgang> Well, with this argument you can block all progress and free=
ze all
> =A0Wolfgang> development to some ancient state.
>
> We only break backwards compatibility when we have to. There's no
> technical reason for renaming the existing make targets.

I agree, and I feel pretty strongly on this point.  The meaning of the
uImage target should not change.  The new format must use a different
target name.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

Return-Path: <glikely@secretlab.ca>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.210.179]) by ozlabs.org (Postfix) with ESMTP id 4BD8A1007D6
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 13 Jan 2010 01:33:33 +1100 (EST)
Received: by yxe9 with SMTP id 9so11621966yxe.26
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 12 Jan 2010 06:33:31 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <201001120806.03728.roman.fietze@telemotive.de>
References: <200912081339.50722.roman.fietze@telemotive.de>
	<200912220759.23453.roman.fietze@telemotive.de>
	<fa686aa41001111115g3451c9b9h4d6c551afd5698e1@mail.gmail.com>
	<201001120806.03728.roman.fietze@telemotive.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 12 Jan 2010 07:33:11 -0700
Message-ID: <fa686aa41001120633h7a4fe756u7e4c701e6bb9cbb0@mail.gmail.com>
Subject: Re: [PATCH 02/13] powerpc/5200: LocalPlus driver: use SCLPC register
	structure
To: Roman Fietze <roman.fietze@telemotive.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jan 12, 2010 at 12:06 AM, Roman Fietze
<roman.fietze@telemotive.de> wrote:
> Hello Grant,
>
> On Monday 11 January 2010 20:15:58 Grant Likely wrote:
>
>> No patch description? =A0Very few patches are sufficiently described by
>> the subject line alone. =A0Tell me what the problem is, what the patch
>> changes, and why.
>
> And a lot of other information. Thank you very much for the effort you
> put into those patches. I almost knew that you will criticize e.g.
> patches that mix functional and "optical" changes, patches that are
> not describing more exactly what I did.
>
> As soon as I have some time left I will try to go once more from the
> original driver to the final driver using clear and separate, well
> bescribed patches, of course taking care of your and other people
> comments.

Sounds good.  I look forward to seeing them.

g.

>
> Again, thanks
>
>
> Roman
>
> --
> Roman Fietze =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Telemotive AG B=FCro M=FChlha=
usen
> Breitwiesen =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A073=
347 M=FChlhausen
> Tel.: +49(0)7335/18493-45 =A0 =A0 =A0 =A0http://www.telemotive.de
>
> Amtsgericht Ulm =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0HRB 541321
> Vorstand:
> Peter Kersten, Markus Fischer, Franz Diller, Markus Stolz
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

Return-Path: <glikely@secretlab.ca>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.210.179]) by ozlabs.org (Postfix) with ESMTP id 274FD1007D4
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 13 Jan 2010 01:07:23 +1100 (EST)
Received: by yxe9 with SMTP id 9so11595320yxe.26
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 12 Jan 2010 06:07:21 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <201001120855.59122.roman.fietze@telemotive.de>
References: <200912081339.50722.roman.fietze@telemotive.de>
	<200912220800.54373.roman.fietze@telemotive.de>
	<fa686aa41001111121u5c943fc7p789c0ec0b41af883@mail.gmail.com>
	<201001120855.59122.roman.fietze@telemotive.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 12 Jan 2010 07:07:01 -0700
Message-ID: <fa686aa41001120607m13bd26f3gde65c114c503886f@mail.gmail.com>
Subject: Re: [PATCH 03/13] mpc52xx: add SCLPC register bit definitions
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

On Tue, Jan 12, 2010 at 12:55 AM, Roman Fietze
<roman.fietze@telemotive.de> wrote:
> Hello Grant,
>
> On Monday 11 January 2010 20:21:22 Grant Likely wrote:
>
>> Unrelated whitespace change?
>
> My fault, as with some other white space changes. My Emacs is
> configured using some older setup found in a 2.4
> Documentation/CodingStyle. Before saving a file my spine is used to
> reformat the whole source file, which then causes those artefacts.
> I'll fix the Emacs setup and try to fix my spine, and double check
> before commits.
>
> BTW: no Emacs users amongst the kernel coders any more? At least I
> have to read "So, you can either get rid of GNU emacs, or ...".

I believe there are lots of emacs using kernel hackers.  emacs is fine
and most of the style changes you were making were valid, but they
were unrelated and unimportant.  Unless emacs is making automatic
changes to the files, it sounds like your emacs config is just fine.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

Return-Path: <jacmet@gmail.com>
Received: from mail-ew0-f214.google.com (mail-ew0-f214.google.com
	[209.85.219.214]) by ozlabs.org (Postfix) with ESMTP id 29BD5B6EF5
	for <linuxppc-dev@ozlabs.org>; Sun,  3 Jan 2010 19:06:14 +1100 (EST)
Received: by ewy6 with SMTP id 6so12894297ewy.9
	for <linuxppc-dev@ozlabs.org>; Sun, 03 Jan 2010 00:06:13 -0800 (PST)
Sender: Peter Korsgaard <jacmet@gmail.com>
From: Peter Korsgaard <jacmet@sunsite.dk>
To: Wolfgang Denk <wd@denx.de>
Subject: Re: [PATCH v2 3/3] powerpc: Add support for ram filesystems in FIT
	uImages
References: <1261446643-21714-1-git-send-email-ptyser@xes-inc.com>
	<1261446643-21714-4-git-send-email-ptyser@xes-inc.com>
	<fa686aa40912301502x48785614ya4dd5c71815a7633@mail.gmail.com>
	<20091231224439.AF5353F6D1@gemini.denx.de>
	<1262301038.29396.137.camel@localhost.localdomain>
	<20100101104449.6DAC63F6FF@gemini.denx.de>
Date: Sun, 03 Jan 2010 09:06:11 +0100
In-Reply-To: <20100101104449.6DAC63F6FF@gemini.denx.de> (Wolfgang Denk's
	message of "Fri, 01 Jan 2010 11:44:49 +0100")
Message-ID: <87wrzzpq8c.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Peter Tyser <ptyser@xes-inc.com>, linux-kbuild@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>>>>> "Wolfgang" == Wolfgang Denk <wd@denx.de> writes:

 >> What do you think about changing the U-Boot documentation to rename
 >> those 2 image types to:
 >> 1 uImages
 >> 2 FIT Images

 Wolfgang> Let's make this "uImage.old" (or "uImage.legacy" similar) and
 Wolfgang> "uImage", then.

No, that would break stuff for the existing users. The existing format
make/file names shouldn't change.

The FIT images could be called fitimage or uImage.new or something.

-- 
Bye, Peter Korsgaard

Return-Path: <jacmet@gmail.com>
Received: from mail-ew0-f214.google.com (mail-ew0-f214.google.com
	[209.85.219.214]) by ozlabs.org (Postfix) with ESMTP id 5C0A2B6F04
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Jan 2010 01:27:05 +1100 (EST)
Received: by ewy6 with SMTP id 6so13048761ewy.9
	for <linuxppc-dev@ozlabs.org>; Sun, 03 Jan 2010 06:27:03 -0800 (PST)
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
	<87wrzzpq8c.fsf@macbook.be.48ers.dk>
	<20100103095032.8F05AE34A26@gemini.denx.de>
Date: Sun, 03 Jan 2010 15:27:00 +0100
In-Reply-To: <20100103095032.8F05AE34A26@gemini.denx.de> (Wolfgang Denk's
	message of "Sun, 03 Jan 2010 10:50:32 +0100")
Message-ID: <87skanp8ln.fsf@macbook.be.48ers.dk>
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

Hi,

 >> No, that would break stuff for the existing users. The existing format
 >> make/file names shouldn't change.

 Wolfgang> Well, with this argument you can block all progress and freeze all
 Wolfgang> development to some ancient state.

We only break backwards compatibility when we have to. There's no
technical reason for renaming the existing make targets.

 >> The FIT images could be called fitimage or uImage.new or something.

 Wolfgang> I disagree. We want to make this the new default, so let's
 Wolfgang> use the default name for this, and continue to support he
 Wolfgang> legacy image format using another name.

 Wolfgang> Also, your approach does not scale. Assume we come up with an
 Wolfgang> even more advanced image format in the future - how should we
 Wolfgang> name it then?  "uImage.newer" ? "uImage.verynew" ?
 Wolfgang> "uImage.new2" ?

Hence fitimage. The next thing will presumably be called something else
again.

-- 
Bye, Peter Korsgaard

Return-Path: <jacmet@gmail.com>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.156])
	by ozlabs.org (Postfix) with ESMTP id 7CAD0DDF55
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Sep 2008 17:55:45 +1000 (EST)
Received: by fg-out-1718.google.com with SMTP id d23so1417630fga.39
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Sep 2008 00:55:43 -0700 (PDT)
To: Wolfgang Denk <wd@denx.de>
Subject: Re: [PATCH v2] bootwrapper: support u-boot multi component images
References: <1221814210-4738-1-git-send-email-jacmet@sunsite.dk>
	<20080922074128.A66F22487F@gemini.denx.de>
From: Peter Korsgaard <jacmet@sunsite.dk>
Date: Mon, 22 Sep 2008 09:55:40 +0200
In-Reply-To: <20080922074128.A66F22487F@gemini.denx.de> (Wolfgang Denk's
	message of "Mon\, 22 Sep 2008 09\:41\:28 +0200")
Message-ID: <874p48y5qb.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: Peter Korsgaard <jacmet@gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>>> "Wolfgang" == Wolfgang Denk <wd@denx.de> writes:

Hi,

 >> Support uImage.<platform>, which are U-Boot multi component images
 >> containing a kernel, dtb and possibly an initrd.

 Wolfgang> NAK.

 Wolfgang> Please do not add such a patch to mainline.

I agree that FIT images probably are the way to go for the future, but
I do think there's room for uImage.% just like we have cuImage.% for
really old uboots.

I'm sure a patch adding FIT images support to bootwrapper would be
appreciated.

-- 
Bye, Peter Korsgaard

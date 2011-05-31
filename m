Return-Path: <larry.finger@gmail.com>
Received: from mail-yx0-f170.google.com (mail-yx0-f170.google.com
	[209.85.213.170]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E7DCDB6F75
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Jun 2011 02:17:17 +1000 (EST)
Received: by yxi11 with SMTP id 11so2542316yxi.15
	for <linuxppc-dev@ozlabs.org>; Tue, 31 May 2011 09:17:14 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <4DE51487.1000808@lwfinger.net>
Date: Tue, 31 May 2011 11:17:11 -0500
From: Larry Finger <Larry.Finger@lwfinger.net>
MIME-Version: 1.0
To: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH] ssb: pci: implement serdes workaround
References: <1301657212-12126-1-git-send-email-zajec5@gmail.com>	<m2vcwr9pn8.fsf@linux-m68k.org>
	<4DE505C6.8020601@lwfinger.net> <m3wrh6hnmn.fsf@linux-m68k.org>
In-Reply-To: <m3wrh6hnmn.fsf@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=
	<public-zajec5-Re5JQEeQqe8AvxtiuMwx3w@plane.gmane.org>,
	=?UTF-8?B?TWljaGE=?= =?UTF-8?B?ZWwgQsO8c2No?=
	<public-mb-fseUSCV1ubazQB+pC5nmwQ@plane.gmane.org>,
	public-b43-dev-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@plane.gmane.org,
	linuxppc-dev@ozlabs.org, "John W. Linville"
	<public-linville-2XuSBdqkA4R54TAoqtyWWQ@plane.gmane.org>,
	public-linux-wireless-u79uwXL29TY76Z2rM5mHXA@plane.gmane.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/31/2011 10:54 AM, Andreas Schwab wrote:
> Larry Finger<Larry.Finger@lwfinger.net>  writes:
>
>>  From the traceback, it must be the serdes_pll_device read that failed.
>
> Why not ssb_pcicore_polarity_workaround (note r4 == 0x134)?

Mainly because the last two steps in the traceback are

[c2ca5c40] [f2146244] ssb_pcie_read+0x4c/0x54 [ssb]
[c2ca5c50] [f2146440] ssb_pcicore_serdes_workaround+0x1c/0x170 [ssb]

Larry

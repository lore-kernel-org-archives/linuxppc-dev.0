Return-Path: <tmarri@apm.com>
Received: from exprod5og117.obsmtp.com (exprod5og117.obsmtp.com [64.18.0.149])
 by ozlabs.org (Postfix) with SMTP id 081D8B6F7C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Oct 2011 09:45:53 +1100 (EST)
Received: by qyk7 with SMTP id 7so1140798qyk.8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Oct 2011 15:45:50 -0700 (PDT)
From: Tirumala Marri <tmarri@apm.com>
References: <1318630114-14064-1-git-send-email-tmarri@apm.com>
 <CAHM4w1k+-KgpkW4QzRkq5wDZK0+VdVhD_QLkJy24HB0s+pE8fg@mail.gmail.com>
In-Reply-To: <CAHM4w1k+-KgpkW4QzRkq5wDZK0+VdVhD_QLkJy24HB0s+pE8fg@mail.gmail.com>
MIME-Version: 1.0
Date: Tue, 25 Oct 2011 15:45:49 -0700
Message-ID: <adb0006ab8a5fe968bda420e861af0ba@mail.gmail.com>
Subject: RE: [PATCH v15 00/10] Add-Synopsys-DesignWare-HS-USB-OTG-driver
To: Pratyush Anand <pratyush.anand@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: greg@kroah.com, linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Pratyush,
<
<Hi Tirumala,
<
<I have reviwed all the patches.
<Thanks for taking my most of the diffs over your v13.
<There are few thing, which are really very important like,
<AHB disable check, EP Disable/Stall (have commented about them in
<respective patches). I am doubtful, that how does all of usbcv test
<cases passes
<without those modifications.
<So, please have a look on those comments.
<You may  add my signed-off.
<
[Tirumala Marri]  I don't do all the unit tests before submission.
I only do few device tests like Ethernet and file backed storage.
For host mode I do some basic IO test. I will try embed your suggestions.
Thx,
Marri

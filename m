Return-Path: <tmarri@apm.com>
Received: from exprod5og102.obsmtp.com (exprod5og102.obsmtp.com [64.18.0.143])
 by ozlabs.org (Postfix) with SMTP id 3DB8A1007D2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Oct 2011 04:17:22 +1100 (EST)
Received: by mail-qw0-f44.google.com with SMTP id c10so1680113qad.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Oct 2011 10:17:20 -0700 (PDT)
From: Tirumala Marri <tmarri@apm.com>
References: <1318630114-14064-1-git-send-email-tmarri@apm.com>
 <20111021173302.GB27652@quad.lixom.net>	<c898f5030d342baa4df570317536bcf2@mail.gmail.com>
 <CAOesGMhVuxbqq7cmm2XVUof9vEifAL=GpPirYb8148a24upJCw@mail.gmail.com>
In-Reply-To: <CAOesGMhVuxbqq7cmm2XVUof9vEifAL=GpPirYb8148a24upJCw@mail.gmail.com>
MIME-Version: 1.0
Date: Wed, 26 Oct 2011 10:17:19 -0700
Message-ID: <0a2f495d6415e9cad48ae2c75c582e0d@mail.gmail.com>
Subject: RE: [PATCH v15 00/10] Add-Synopsys-DesignWare-HS-USB-OTG-driver
To: greg@kroah.com
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Greg,

<
<No, just start over from scratch. Just leave the crap driver behind,
<use it for reference but write the new one.
<
<It's obvious given that you are already at iteration v15 and it's
<still looking this bad that this is not realistic to get reviewed and
<accepted as-is. I don't think staging is a good target either -- what
<the driver really needs is _functional_ cut-down to only cover the use
<cases that your product uses, and staging cleanups are mostly around
<style and refactoring, not changing, fixing or removing functionality.
<
<> <Compare this to the dwc3 driver, which is much much cleaner.
<> <
Could you please comment on this. This has been reviewed so many times
And we did the major changes. I think it is un-acceptable to say to
re-write
The driver now after 15 reviews? This should have happened in first 5
reviews.


Thx,
Marri

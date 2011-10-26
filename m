Return-Path: <tmarri@apm.com>
Received: from exprod5og105.obsmtp.com (exprod5og105.obsmtp.com [64.18.0.180])
 by ozlabs.org (Postfix) with SMTP id 2D8E41007D2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Oct 2011 03:07:01 +1100 (EST)
Received: by mail-qw0-f43.google.com with SMTP id g1so2082302qab.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Oct 2011 09:06:58 -0700 (PDT)
From: Tirumala Marri <tmarri@apm.com>
References: <1318630114-14064-1-git-send-email-tmarri@apm.com>
 <20111021173302.GB27652@quad.lixom.net>	<c898f5030d342baa4df570317536bcf2@mail.gmail.com>
 <CAOesGMhVuxbqq7cmm2XVUof9vEifAL=GpPirYb8148a24upJCw@mail.gmail.com>
In-Reply-To: <CAOesGMhVuxbqq7cmm2XVUof9vEifAL=GpPirYb8148a24upJCw@mail.gmail.com>
MIME-Version: 1.0
Date: Wed, 26 Oct 2011 09:06:55 -0700
Message-ID: <d4b201db8e7510eeeca77dc26dab02c1@mail.gmail.com>
Subject: RE: [PATCH v15 00/10] Add-Synopsys-DesignWare-HS-USB-OTG-driver
To: Olof Johansson <olof@lixom.net>
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
[Tirumala Marri] I like to hear What maintainer GregKH thinks. We already
spent lot
Of time on it and passed multiple hands.
--marri

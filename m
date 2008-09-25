Return-Path: <pku.leo@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.190])
	by ozlabs.org (Postfix) with ESMTP id A2095DDF45
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Sep 2008 19:12:24 +1000 (EST)
Received: by nf-out-0910.google.com with SMTP id e27so146423nfd.9
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Sep 2008 02:12:21 -0700 (PDT)
Message-ID: <2a27d3730809250212q4092d0bbyc6aa68723ff22c29@mail.gmail.com>
Date: Thu, 25 Sep 2008 17:12:21 +0800
From: "Leo Li" <pku.leo@gmail.com>
To: "Wang Jian" <lark@linux.net.cn>
Subject: Re: [PATCH] pata_platform struct resource signness fix
In-Reply-To: <20080925083622.GA2701@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
References: <20080925083622.GA2701@debian>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Sep 25, 2008 at 4:36 PM, Wang Jian <lark@linux.net.cn> wrote:
> Hi,
>
> This patch is to pata_platform.c but at this time, it's powerpc specific
> because it can only be triggerred using openfirmware, so I post the patch
> here. The patch is against 2.6.26-rc8.

Powerpc isn't the only arch to use openfirmware.  Anyway, you have to
cc linux-ide@vger.kernel.org if you want the patch to be merged.

- Leo

Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id EB4EFDDF82
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Sep 2008 07:09:51 +1000 (EST)
Date: Mon, 29 Sep 2008 16:14:02 -0500
From: Olof Johansson <olof@lixom.net>
To: Tirumala Reddy Marri <tmarri@amcc.com>
Subject: Re: Disabling L1 D-cache and side effects
Message-ID: <20080929211401.GA22039@lixom.net>
References: <9323BAFB78DE7C4183466AD03F73EA424D46071D@SDCEXCHANGE01.ad.amcc.com>
	<AC5E1C3367E37D44970B81A6ADD1DA2C060530C1@SDCEXCHANGE01.ad.amcc.com>
	<20080929180455.GA19014@lixom.net>
	<AC5E1C3367E37D44970B81A6ADD1DA2C060531D6@SDCEXCHANGE01.ad.amcc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AC5E1C3367E37D44970B81A6ADD1DA2C060531D6@SDCEXCHANGE01.ad.amcc.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Sep 29, 2008 at 02:00:06PM -0700, Tirumala Reddy Marri wrote:
>  Olof,
>   Thanks for the response.
> 
>   Is there a piece of code in Linux which does the Machine check
> recovery and continue normal execution ?

Yes, there is. Several pieces, actually.


-Olof

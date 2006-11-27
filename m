Return-Path: <tnt@246tNt.com>
Received: from outmx004.isp.belgacom.be (outmx004.isp.belgacom.be
	[195.238.4.101])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DD9AB67DE4
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Nov 2006 08:40:22 +1100 (EST)
Received: from outmx004.isp.belgacom.be (localhost [127.0.0.1])
	by outmx004.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id kARLeDWm012581
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Nov 2006 22:40:13 +0100
	(envelope-from <tnt@246tNt.com>)
Message-ID: <456B5B28.4000105@246tNt.com>
Date: Mon, 27 Nov 2006 22:39:52 +0100
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: MPC52xx support rework for 2.6.20
References: <1164662190802-git-send-email-grant.likely@secretlab.ca>
In-Reply-To: <1164662190802-git-send-email-grant.likely@secretlab.ca>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

As indicated in each patch description, I acked those.

I also tested them, they work "out-of-the-box" for both lite5200 and
lite5200b.


    Sylvain

Grant Likely wrote:
> Rework mpc52xx support in arch/powerpc and add support for lite5200 eval
> boards.  This patchset only covers the board support code.  Device
> drivers will be sent in a seperate patchset as they need to cc: other
> mailing lists
>
> The whole set of pending mpc52xx patches can also be pulled from:
> git://git.secretlab.ca/srv/git-trees/public/git/linux-2.6.git#lite5200-merge
>
>
>   

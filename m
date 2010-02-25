Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9CE1FB7C48
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Feb 2010 05:27:35 +1100 (EST)
Subject: Re: Gianfar driver failing on MPC8641D based board
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <4B86A97E.6050509@ge.com>
Date: Thu, 25 Feb 2010 12:27:21 -0600
Message-Id: <1446F46F-683F-49F7-BBD4-2113A26B0DAB@kernel.crashing.org>
References: <4B6C2488.3060403@ge.com> <4B865176.7080806@ge.com>
	<4B86A97E.6050509@ge.com>
To: Martyn Welch <martyn.welch@ge.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Sandeep Gopalpet <Sandeep.Kumar@freescale.com>,
	Anton Vorontsov <avorontsov@ru.mvista.com>, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Feb 25, 2010, at 10:46 AM, Martyn Welch wrote:

> 
> Further testing has shown that this isn't restricted to warm reboots, it
> happens from cold as well. In addition, the exact timing of the failure
> seems to vary, some boots have got further before failing.

what mechanism do you use for warm resets?

- k

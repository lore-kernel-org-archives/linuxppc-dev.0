Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A6C2467A3F
	for <linuxppc-dev@ozlabs.org>; Thu, 18 May 2006 20:36:05 +1000 (EST)
Subject: RE: [PATCH/2.6.17-rc4 1/10] Powerpc: Add general support for mpc7
	448h pc2 (Taiga) platform
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Zang Roy-r61911 <tie-fei.zang@freescale.com>
In-Reply-To: <9FCDBA58F226D911B202000BDBAD4673062C0A97@zch01exm40.ap.freescale.net>
References: <9FCDBA58F226D911B202000BDBAD4673062C0A97@zch01exm40.ap.freescale.net>
Content-Type: text/plain
Date: Thu, 18 May 2006 20:35:52 +1000
Message-Id: <1147948552.5192.9.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Yang Xin-Xin-r48390 <Xin-Xin.Yang@freescale.com>,
	Paul Mackerras <paulus@samba.org>, Alexandre.Bounine@tundra.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2006-05-18 at 18:21 +0800, Zang Roy-r61911 wrote:
>  > On Thu, 2006-05-18 at 15:12 +0800, Zang Roy-r61911 wrote:
> > > > I'm not repeating Kumar's comments about that CONFIG_7xxx 
> > > > thing and that
> > > > 7xxx/ directory, it should all go.
> > > > 
> > > 
> > > Should I move my code to embedded6xx?
> > 
> > Probably for now yes.
> 
> I can migrate my code to embedded6xx technically. In fact, 
> I can move it into anywhere in the arch/powerpc/platforms. 
> While for mpc7448hpc2(taiga) board, it is not a embedded 
> application board. It is a high performance server! It seems
> odd to put code there :). What's your opinion?

I think we should do a platform/generic for boards that don't need more
than a single platform file, which I think will be the case once we are
done with your port ;)

Ben.

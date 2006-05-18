Return-Path: <tie-fei.zang@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 8CF1267A64
	for <linuxppc-dev@ozlabs.org>; Thu, 18 May 2006 20:49:15 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	k4IB96SK023777
	for <linuxppc-dev@ozlabs.org>; Thu, 18 May 2006 04:09:06 -0700 (MST)
Received: from zch01exm40.ap.freescale.net (zch01exm40.ap.freescale.net
	[10.192.130.11])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id k4IAnC1U000472
	for <linuxppc-dev@ozlabs.org>; Thu, 18 May 2006 05:49:13 -0500 (CDT)
Message-ID: <9FCDBA58F226D911B202000BDBAD4673062C0AD2@zch01exm40.ap.freescale.net>
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: RE: [PATCH/2.6.17-rc4 1/10] Powerpc: Add general support for mpc7
	448h pc2 (Taiga) platform
Date: Thu, 18 May 2006 18:49:10 +0800
MIME-Version: 1.0
Content-Type: text/plain
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

 
> On Thu, 2006-05-18 at 18:21 +0800, Zang Roy-r61911 wrote:
> >  > On Thu, 2006-05-18 at 15:12 +0800, Zang Roy-r61911 wrote:
> > > > > I'm not repeating Kumar's comments about that CONFIG_7xxx 
> > > > > thing and that
> > > > > 7xxx/ directory, it should all go.
> > > > > 
> > > > 
> > > > Should I move my code to embedded6xx?
> > > 
> > > Probably for now yes.
> > 
> > I can migrate my code to embedded6xx technically. In fact, 
> > I can move it into anywhere in the arch/powerpc/platforms. 
> > While for mpc7448hpc2(taiga) board, it is not a embedded 
> > application board. It is a high performance server! It seems
> > odd to put code there :). What's your opinion?
> 
> I think we should do a platform/generic for boards that don't 
> need more
> than a single platform file, which I think will be the case 
> once we are
> done with your port ;)
> 
> Ben.
> 
> 
I will implement my board port as early as I can  
according to the feedback :).

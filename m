Return-Path: <benh@kernel.crashing.org>
Subject: RE: Follow up on 4 Gig of DDR on  MPC8548E
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Morrison, Tom" <tmorrison@empirix.com>
In-Reply-To: <BD261180E6D35F4D9D32F3E44FD3D901053E84E5@EMPBEDEX.empirix.com>
References: <mailman.1956.1182519826.2671.linuxppc-dev@ozlabs.org>
	<BD261180E6D35F4D9D32F3E44FD3D90108361D90@EMPBEDEX.empirix.com>
	<DCEAAC0833DD314AB0B58112AD99B93B0310C3ED@ismail.innsys.innovsys.com>
	<BD261180E6D35F4D9D32F3E44FD3D901053E84E5@EMPBEDEX.empirix.com>
Content-Type: text/plain
Date: Tue, 26 Jun 2007 09:32:03 +1000
Message-Id: <1182814323.5521.143.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, ltib@nongnu.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> apparently after more investigations - it looks like there is something in the ext2 driver code
> that is mal-adjusted....I haven't talked to the guy today who was looking at that - but the ext2
> driver code that was openning a 'virtual file' / console - had some problems mapping that
> space - again, my gut is telling me more stronger there is a problem with signed/unsigned...
> now deeper in the ext2 code...

I very much doubt there is a signed/unsigned issue in ext2 or
elsewhere...

You have CONFIG_HIGHMEM ? What are your setting for KERNELBASE and
PAGE_OFFSET ?

Ben.

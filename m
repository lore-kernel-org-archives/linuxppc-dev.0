Return-Path: <crn@netunix.com>
Date: Wed, 7 Oct 2009 21:54:34 +0100 (BST)
From: Chris Newport <crn@netunix.com>
To: Mitch Bradley <wmb@firmworks.com>
Subject: Re: [RFC PATCH 00/12] Merge common OpenFirmware device tree code
In-Reply-To: <4ACCEC67.9070106@firmworks.com>
Message-ID: <Pine.LNX.4.60.0910072148040.11795@mailgate.netunix.com>
References: <20091007041007.16890.62194.stgit@angua>
	<fa686aa40910062149p5d7141e4x3ff849fd4d191f38@mail.gmail.com>
	<646765f40910062218s19d540f9q14c9086bedd1d9da@mail.gmail.com>
	<20091007135243.GC21646@anhedonia> <4ACCEC67.9070106@firmworks.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Sam Creasey <sammy@sammy.net>, Stephen Rothwell <sfr@canb.auug.org.au>,
	Julian Calaby <julian.calaby@gmail.com>,
	devicetree-discuss@lists.ozlabs.org,
	microblaze-uclinux@itee.uq.edu.au, sparclinux@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 7 Oct 2009, Mitch Bradley wrote:

> Taking this one step further, I don't see any real good reason to continue 
> supporting Sun4 going forward.  I got rid of my Sun4 systems long ago because 
> it was just too hard to keep them working - after having used them long after 
> most people had moved on.  Dropping Sun3 and Sun4 eliminates all vestiges of 
> the sunmon interface and also allows dropping support for OBP version 1, 
> which only shipped on SS1-class machines - the first machines in the Sun4c 
> subclass.

Sun4c has also been broken for a long time and sun4d has never worked
properly. Is it time to also prune these ?.
That would leave only Sun4m in the 32bit kernel, which still works and
has plenty of ongoing user interest.

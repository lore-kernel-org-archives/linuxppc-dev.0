Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <20080505011607.GA9349@yookeroo.seuss>
References: <20080425134805.GP6692@pengutronix.de>
	<20080505011607.GA9349@yookeroo.seuss>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <1328d38bed8a830af756850bbaf2e8ad@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] add Phytec pcm030 board support
Date: Mon, 5 May 2008 20:06:48 +0200
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> Add board support for the Phytec pcm030 mpc5200b based board. It
>> does not need any platform specific fixups and as such is handled
>> as a mpc5200 simple platform.
>
> Those still whingeing about how horrible and hard and tedious the new
> world of device trees is, take note.  We've certainly had some
> teething problems as we all figure out how to use the device tree
> properly.  But this is the payoff: support for a new board added with
> one text file.  It's only going to get more common.

/me imagines a world where every sane device (not just PowerPC)
uses OF device trees...

Oh well, back to reality.


Segher

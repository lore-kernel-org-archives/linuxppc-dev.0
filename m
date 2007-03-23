Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH] force -mno-string option on cell
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <b7160f3020aae6e7926b79c14939750c@kernel.crashing.org>
References: <1174544624.10836.24.camel@localhost.localdomain>
	<94d8e19d4b061504fcfd08d1ab70cc78@kernel.crashing.org>
	<20070323120619.GA7472@localhost.localdomain>
	<94FD59E6-B618-4AB2-9BAB-D40A70CC1589@kernel.crashing.org>
	<b7160f3020aae6e7926b79c14939750c@kernel.crashing.org>
Content-Type: text/plain
Date: Sat, 24 Mar 2007 06:46:48 +1100
Message-Id: <1174679208.10836.71.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Arnd Bergmann <arnd@arndb.de>, Akinobu Mita <mita@fixstars.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2007-03-23 at 17:35 +0100, Segher Boessenkool wrote:
> > Nack.  If GCC is now putting string instructions even if you don't 
> > specify -mstring than we also need this for CONFIG_FSL_BOOKE.  Please 
> > fix that up as well.
> 
> In the absence of -mstring and -mno-string options,
> GCC will default to either on or off based on other
> options (CPU model, mostly).  This is good behaviour
> since it intends to give you the best code sequences
> for whatever CPU you selected (or for a blended CPU
> model etc).

strings instructions suck, get away with it.

Ben.

Date: Mon, 9 Feb 2004 13:13:40 -0800
From: Brad Boyer <flar@allandria.com>
To: Costantino Pistagna <cpistagna@vrlteam.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: ibook G4 Status Report
Message-ID: <20040209211340.GA18028@pants.nu>
References: <27203D60-5B28-11D8-A96D-000A95B30208@vrlteam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <27203D60-5B28-11D8-A96D-000A95B30208@vrlteam.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Feb 09, 2004 at 06:48:22PM +0100, Costantino Pistagna wrote:
> A minor request is about the status of Broadcom BCM94306 driver. Looking
> around i've noticed that many new Centrino-Based laptop are equipped
> with
> this wificard. After some minutes of googling i've reached a sf.net
> hosted project
> about a .vxd/Windows drivers wrapper; it successfully use the windows
> drivers
> for the above card under x86/linux. is there any way to use this method
> under
> linuxppc ?. Another time: any clues? and/or usefull start point ?

I don't remember if it was on this list, but I did write up a short
list of what it would take to get osx drivers running, at it's pretty
extensive. It might be easier to get an x86 emulator running enough
to use the windows driver and the vxd wrapper hack.

The problem is that osx has a lot of support code built into the
kernel that gets used by every driver. It's nice for the person
writing the driver, but a pain for someone trying to emulate it.

	Brad Boyer
	flar@allandria.com


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Derrik Pates <dpates@dsdk12.net>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: Again with the firewire
Date: Sat, 24 Nov 2001 13:21:19 +0100
Message-Id: <20011124122119.19280@smtp.wanadoo.fr>
In-Reply-To: <Pine.LNX.4.40.0111231904220.14868-100000@andromeda.dsdk12.net>
References: <Pine.LNX.4.40.0111231904220.14868-100000@andromeda.dsdk12.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>After another test on my part, I discovered that I am not seeing a freeze
>on hotplugging. Probably put this iBook to sleep before I plugged the CD
>burner in, and the FireWire controller was already a lost cause.
>
>Also, a heads up - I've found that unloading 'ohci1394' before suspend and
>reloading it after yields a working system, no freezes after unsuspend. At
>least on this FireWire iBook, anyway. If I don't, the system hangs after
>unsuspending as soon as a FireWire device is accessed. May be useful for
>suspend handling in the driver itself.

Yes, unloading the driver should be enough.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

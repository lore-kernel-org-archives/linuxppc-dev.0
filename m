From: Benjamin Herrenschmidt <bh40@calva.net>
To: Henry Worth <haworth@ncal.verio.com>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Darwin updates
Date: Wed, 16 Aug 2000 14:41:12 +0200
Message-Id: <20000816124112.4310@smtp.calvacom.fr>
In-Reply-To: <3994B357.E3FE9014@ncal.verio.com>
References: <3994B357.E3FE9014@ncal.verio.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>I tried syncing up my copy of the Darwin xnu project today.
>The server was down for a while, but now that it is up there
>are new updates. A real quick look shows Pismo sleep is enabled
>in the core99 drivers (they still haven't sanitized out the
>use of the word "Pismo"). I also noticed some updates to the
>PMU ADB, network and USB drivers, and the HFS code.  There
>is no sign of explict support for the cube or dual G4's in
>the Core99 drivers (though the uniNorth network drivers
>have had some gigabit code for a while).

I've seen some XNU updates last week, but AFAIK, the sleep code was still
far from beeing complete. I'll re-check asap.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

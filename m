From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ira Weiny <iweiny@acm.org>,
	linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Cardbus issues on TiBook
Date: Fri, 7 Sep 2001 19:06:30 +0200
Message-Id: <20010907170630.852@smtp.adsl.oleane.com>
In-Reply-To: <3B98F783.1266EC60@acm.org>
References: <3B98F783.1266EC60@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>Also I used this line "sysmap=/boot/System.map-fw" to load the system
>map but then I realized you said OpenFirmware path.  How do I calculate
>the openfirmware path to the system map?  And would this be dynamic when
>I recompile if I just put the file in the filesystem or would I have to
>reload it with ybin?  Thanks again for all your help.


Put the System.map net to the kernel, and copy/paste the kernel path ;)

Ben/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

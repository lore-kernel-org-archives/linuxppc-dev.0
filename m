Date: Mon, 5 Mar 2001 11:52:55 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.linuxppc.org,
	"David S. Miller" <davem@redhat.com>
Subject: Re: IO issues vs. multiple busses 
In-Reply-To: <19350125201706.1788@mailhost.mipsys.com>
Message-ID: <Pine.HPX.4.10.10103051139240.3908-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 3 Mar 2001, Benjamin Herrenschmidt wrote:

> Right. That's my opinion too. But it's difficult to make everybody agree
> on it ;) Even the simple mecanism Paul Mackerras did so that IOs to
> non-existent devices don't kill the kernel (very small overhead) caused
> some barking ;)

Because it is ostrich's policy. I for one prefer machine checks and a dead
kernel to know where the problems are rather than silently ignoring them.
Fortunately I can patch my kernels, thanks god for open-source ;)

Having a special set of macros to tell that you want to handle machine
checks and return an error code in this case would be fine, burying the
head in the sand on _every_ I/O access is wrong.

	Regards,
	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

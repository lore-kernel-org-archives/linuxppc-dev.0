Date: Wed, 17 Nov 1999 12:06:26 -0800 (PST)
From: Ani Joshi <ajoshi@shell.unixbox.com>
To: "David N. Welton" <davidw@linuxcare.com>
cc: Linux -Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: again 2.3.28
In-Reply-To: <19991117115340.D4281@bassano.linuxcare.com>
Message-ID: <Pine.LNX.4.10.9911171203510.5504-100000@shell.unixbox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Wed, 17 Nov 1999, David N. Welton wrote:

> This is indeed a CHRP machine, an RS6K F50, to be precise.


	ahh, i assumed you were on a pmac using bootx text console, well
yes, in that case you're
right, you cannot use prom_print there, *but*, benh has recently done
something about this, check his ibook patches or somewhere on this page
for this.  he said he wanted to get this done, but i'm not sure if he has
finished it yet.


ani


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Date: Wed, 17 Nov 1999 11:43:40 -0800 (PST)
From: Ani Joshi <ajoshi@shell.unixbox.com>
To: "David N. Welton" <davidw@linuxcare.com>
cc: Linux -Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: again 2.3.28
In-Reply-To: <19991117110116.B4281@bassano.linuxcare.com>
Message-ID: <Pine.LNX.4.10.9911171141110.5126-100000@shell.unixbox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Wed, 17 Nov 1999, David N. Welton wrote:

> So, we can't use prom_print to print checkpoints and we can't use
> printk yet.

	you can use prom_print to print until start_kernel, then you can
use printk because console_init() is done very early (unless its dieing
before that which would really suck), but i'm pretty sure you should be
able to prom_print until then.  how are you calling your prints?

btw, what machine is this?


ani


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

In-Reply-To: <38AEFE72.2E9C7300@tiac.net>
Date: Sun, 20 Feb 2000 15:03:39 +0100
To: Patrick Callahan <pac1@tiac.net>, linuxppc-dev@lists.linuxppc.org
From: BenH <bh40@calva.net>
Subject: Re: 2.3.45 on B&W G3 PCI-PCI Bridge scan - Is this a problem in earlier kernels?
Message-Id: <20000220150339.012539@192.168.1.10>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, Feb 19, 2000, Patrick Callahan <pac1@tiac.net> wrote:

>Is it possible that this PCI-PCI bridge scan timing problem manifests
>itself in earlier kernels on Blue
>G3's as intermittent boot failures?  Ocasionally when I run in MacOS 8.6
>for a time, and then boot into Linux using the BootX application version
>1.2.? the boot gets to the point where it writes out the word booting...
>on the console. but no further.
>
>Is this worth investigating and fixing in the stable kernel if it is
>shown to be a problem there?

Did you try compiling with xmon enabled in the config ? There's a small
buglet in the current devel tree that can break if it's not enabled.

Also, On NewWorld machines, yaboot booting should be more reliable than BootX.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

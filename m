Date: Tue, 11 Jan 2000 09:08:36 +0100
From: Olaf Hering <olh@suse.de>
To: Ethan Benson <erbenson@alaska.net>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: write into OF tree like nvsetenv
Message-ID: <20000111090836.B1620@suse.de>
References: <20000108171526.B8126@suse.de> <v04220818b49df84590b1@[192.168.0.1]> <38785B2C.7807E8FD@wanadoo.fr> <20000109142900.A17353@suse.de> <v04220827b49fa1e99714@[192.168.0.1]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <v04220827b49fa1e99714@[192.168.0.1]>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Jan 10, Ethan Benson wrote:

> 
> On 9/1/2000 Olaf Hering wrote:
> 
> >
> >I want exactly this automatic. This works fine on the current IDE Macs,
> >but with a B&W Scsi Mac a "typical" User has lost.
> >The path on my Mac is something like
> >
> >/pci/pci-bridge/ADPT,2940U2B/@6:7,blah
> >
> >Too complex.
> 
> agreed, OF device paths are gross ;)
...
> in short we have 2 problems right now: 1) we cannot write to OF nvram 
> from linux at the moment and 2) we cannot figure out WHAT to write to 
> it...

We will change this, at least the last. Who solve the first problem? :)


Gruss Olaf

-- 
 $ man 1 current_release

BUGS
       Users never read manuals...

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

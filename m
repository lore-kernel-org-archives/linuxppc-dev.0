Date: Mon, 28 Jun 2004 08:11:19 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Gerhard TAEUBL <Gerhard.TAEUBL@frequentis.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: loading the kernel and root FS separately from flash?
In-Reply-To: <s0e01d9a.092@mail.frequentis.com>
Message-ID: <Pine.LNX.4.60.0406280807580.5556@localhost.localdomain>
References: <s0e01d9a.092@mail.frequentis.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, 28 Jun 2004, Gerhard TAEUBL wrote:

> Hi!
>
> We have the same 'problem' if we startet with linux.
> I think the point is:
> What do you want to update?
> In most cases only project related files like configuration or the
> application itself has to be updated, but not the whole distribution.
> So look what do you think that is necessayr to update and which files
> are not.
> We use a compressed filesystem without the possibilty to update it
> (easily). Then we mount a jffs2 partition where the project related
> files are stored. (In detail: a standard project directory is also
> stored in the compressed filesystem, and if the hardware boots the first
> time, the flashdisk will be formated and the standard application
> copied. So from this point on it could be handled in our system as
> usual, and also newer application could be stored, wihout the need to
> update everything)
>
> I hope you could see now clear .-)

sadly, i need the ability to update arbitrary files anywhere in the
root filesystem on demand (but only on occasion).  updating
application-specific stuff is easy as all that is stored in a totally
separate flash chip, formatted as a single JFFS2 filesystem, so that
part is easy.

it's the fundamental root filesystem contents that are the issue here,
but i think wolfgang has given me what i need to handle this.

rday

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

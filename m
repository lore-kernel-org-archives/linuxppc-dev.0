From: erik.teose@exgate.tek.com
Message-ID: <BA0E4392AD99D040885C414D992C24BE0361528A@us-bv-m11>
To: fray@mvista.com, Christophe.LINDHEIMER@fr.thalesgroup.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: Running Linux with 2Mo of Ram.
Date: Thu, 12 Jun 2003 10:22:41 -0700
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>You will need some type of "execute in place", i.e. run the
>kernel and/or
>userspace applications out of ROM in order to work with 2MB of RAM.
>
>This type of thing is generally very board, processor and
>application specific.
>  So I don't believe there is existing (open source) code to do it.
>
>--Mark

MontaVista's "Consumer Electronics Edition" does xip (execute in place) from
rom. From what I understand, MV has been fairly good about folding their
updates back into the open source world (e.g. real time enhancements to the
kernel). Has this changed?

Erik

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

Message-ID: <3F7D1C02.8060406@kegel.com>
Date: Thu, 02 Oct 2003 23:49:38 -0700
From: Dan Kegel <dank@kegel.com>
MIME-Version: 1.0
To: Philippe Villet <philippe.villet@acterna.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: montavista gcc3.2.1 and USB hotplug  (405GP platform)
References: <OF5BBAD0EA.5A3EB257-ONC1256DB4.001F984E-C1256DB4.0020E13C@se.wavetek.com>
In-Reply-To: <OF5BBAD0EA.5A3EB257-ONC1256DB4.001F984E-C1256DB4.0020E13C@se.wavetek.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Philippe Villet wrote:
> We were compiling Montavista 2.4.18 linuk kernel for our own platform
> based on IBM405GP and a PIIX4 South Bridge.
> Support for usbcore, usb-uhci and hid (keyboard an mouse support) is set
> in the kernel and it works fine when we compile this kernel with
> gcc 2.95. Now compiling exactely the same kernel tree with gcc 3.2.1; It
> doesn't work any more;

I'm not an expert, but I play one on the web.  Here are
a couple ideas that may or may not resemble actual good ideas:
1. reduce the optimization from -O2 to -O1 when building the kernel
2. try gcc-3.3.1.  Can't hurt, and who knows, maybe it'll help.
You can build it yourself fairly easily; see http://kegel.com/crosstool
- Dan

--
Dan Kegel
http://www.kegel.com
http://counter.li.org/cgi-bin/runscript/display-person.cgi?user=78045


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

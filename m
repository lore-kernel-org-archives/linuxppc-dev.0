Message-ID: <007601c394c7$b6bdca40$0700a8c0@eurostudio.local>
Reply-To: "Ing.Gianfranco Morandi" <gianfranco.morandi@euro-studio.it>
From: "Ing.Gianfranco Morandi" <gianfranco.morandi@euro-studio.it>
To: "Jean-Denis Boyer" <jdboyer@m5t.com>
Cc: "LinuxPPC" <linuxppc-embedded@lists.linuxppc.org>
References: <AB5AF73EAF23304EA1B932174137CED70E6EE1@m5tmail.m5t.com>
Subject: Re: unhandled Intterrupt
Date: Fri, 17 Oct 2003 17:54:58 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Jean-Denis wrote:

>Please follow the following threads of discussion, and let us know if that
helps.
>http://lists.linuxppc.org/linuxppc-embedded/200204/msg00074.html
>http://lists.linuxppc.org/linuxppc-embedded/200205/msg00034.html

Dear Jean-Denis,

many thanks for your suggestions, they were really helpful.
First of all, we are working with the ELDK package, and as you know it uses
the 2.4.4 kernel.
By the way we didn't have any spurious Irqs prior to install our deamon and
for this we have
checked (and found!) the problem. As Dan were indicating we had a race
condition during
shutting down and re-starting the deamon.
In the past We have observed the indication of BAD Interrupts when we were
using the 2.4.18
kernel, but at the moment I do not have the possibilty to test it.
I'll keep You informed as well.

Regards

Gianfranco


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

From: Darin.Johnson@nokia.com
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: Failsafe bootloader
Date: Wed, 4 Jun 2003 05:33:53 -0700
Message-ID: <F0B628F30F48064289D8CCC1EE21B7A8012E39D2@mvebe001.americas.nokia.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Of course, this still doesn't protect you from loading a new
> bootrom that
> has a valid checksum but a fatal problem (doh-doh-doh).
> Fortunately, in
> that case the idiot is ourselves and we deserve the pain involved, and
> hopefully learn from it ;-).

The problems we had were first that upgrades could be done
transparently without the user knowing, so you can't
really protect from the user unplugging (though we were
supposed to be an always-on-don't-turn-off product).
Second, have an image with a good checksum that boots
up ok is only part of the story, we have to make sure that
it can communicate correctly on its network.  Ie, the application
software has to communicate to the boot loader that the new
image can be kept.

Also from experience, I've really lost a lot of hair in
situations with other products that say "do not turn off the
power until this update is finished", only to have the product
crash, or the computer that is talking to it crashes.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

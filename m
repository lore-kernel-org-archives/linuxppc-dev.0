Message-ID: <8088727.1061649011686.JavaMail.ernstp@mac.com>
Date: Sat, 23 Aug 2003 16:30:11 +0200
From: Ernst Persson <ernstp@mac.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: linuxppc-2.5 fixlets
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>> Alsa does not seem to produce any sound, whatever I try to do
>> (including messing around with mute), and dmasound doesn't compile at
>> all.
>>
>> Used kernel is 2.6.0-test3, via rsync from
>> source.mvista.com::linuxppc-2.5, as of around 10AM CET (8AM UTC).
>
>Typically enough, I was just pointed to a fix for this problem (for
>alsa) a few minutes after sending this mail.
>
>According to
>http://www.ussg.iu.edu/hypermail/linux/kernel/0308.2/0288.html
>reloading i2c-keywest after loading the alsa-modules initialised things
>so that demuting works. There's also a patch included.

I have something that sounds (no pun intended...) like exactly the same
problem with sound on my iMac, using the burgundy sound driver. Could it
be the same thing? I'll have to try to modify the patch for the burgundy
driver when I get home on friday.

//ernie

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Date: Sun, 19 Sep 1999 10:54:01 +0200
To: dmalek@jlc.net, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: patches: MacOS-like Wallstreet sound in/out controls
Message-Id: <19990919105401.015601@smtp.calvacom.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, Sep 19, 1999, Dan Malek <dmalek@jlc.net> wrote:

>Since I was the last one to check in changes to the driver, I have kind of
>been nominated to do this again.  I have patches from several people for some
>functional updates on new hardware.  I can add these in/out controls if
>people really want them.
>
>
>While I understand the convenience of these in/out controls, I personally
>don't
>like them.  I run a variety of programs that perform these operations for me.
>Sometimes I want to run both line out and speakers at the same time, or
select
>the microphone without having to unplug line in.  I guess the in/out doesn't
>prevent
>me from doing this, just that a change (plug in or out) will cause a
>configuration
>change without my mixer knowing.  If people generally want these, I'll put
>them
>in along with the other changes I am making.


A better solution would  be to make the appropriate infos available to
userland (eventually via a private ioctl of the sound driver). Then, we
could have an optional damon handling all this automatically that can be
unplugged for people who like controlling everything manually. If no-one
have time to write this, then you may include the patches anyway but
wrapped in a compile option. (I'd like the volume button patch anyway).

On a similar way, I'm wondering what is the best way for the eth driver
to tell userland about it's link status. I'd like to add to Paul's pmud a
way to have scripts run when the link goes down and up. (basically, this
would ifdown eth0 completely to remove it from the router, change my
default route to the one I need for PPP, etc...)


-- 
           E-Mail: <mailto:bh40@calva.net>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

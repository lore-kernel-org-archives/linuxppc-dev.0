Message-ID: <3C126A90.C9768C76@folkwang-hochschule.de>
Date: Sat, 08 Dec 2001 20:31:28 +0100
From: =?iso-8859-1?Q?J=F6rn?= Nettingsmeier <nettings@folkwang-hochschule.de>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Subject: Re: 2.4.17-pre[12]-ben0 trees hang on unsuspend
References: <3C1222A8.59C17879@folkwang-hochschule.de> <20011208164612.1404@smtp.wanadoo.fr>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt wrote:
>
> >Benjamin Herrenschmidt wrote:
> >>
> >> >
> >> >so far, it has not died after resume. but it only went through 3
> >> >sleep cycles so far...
> >
> >after a few days of frequent use, i can say that sleep/wakeup
> >bahaviour has improved vastly.
> >however there was again one hard lockup yesterday.
> >i was on the road when it hit, so i haven't been able to ping or ssh
> >into the machine.
> >i think it only happens when you strike a key immediately after
> >sleep, before the standby led starts glowing.
>
> Ok, I'll do some experiments and see if I can find something.

let me know if can test something for you.
is there any bulletproof method to capture kernel messages on a
pismo when it goes bang ?
has somebody used the modem port as a serial console ? i have a
spare modem lying around, perhaps it might be worth trying...

> >> >btw, alsa compiles now, the feature.h header is there.
> >> >
> >> >thanks,
> >>
> >> feature.h ? That one is gone and have been replaced by pmac_feature.h
> >> for some time now. Maybe Alsa was fixed to handle the new mecanism.
> >
> >oops, my fault. i had manually copied the feature.h from the
> >"official tree" into yours some days ago, and of course it remained
> >there when i rsynced again....
> >yes, alsa compiles even without that old header. looks like it has
> >been fixed.
> >
> >anyway, it seems that the kernel.org tree still has feature.h, and
> >not pmac-feature.h. if the new mechanism is consensus, it should be
> >propagated to the official tree asap, so that port maintainers
> >become aware of it. my reports about the compile problems to
> >alsa-dev were ignored, because people could not make sense of me
> >whining about a missing header that was obviously there.
>
> Patches are in marcelo's hands, they should be in 2.4.17 before
> it goes final.

good news !


thanks for your quick responses and your help.

best,

jörn

--
Jörn Nettingsmeier
home://Kurfürstenstr.49.45138.Essen.Germany
phone://+49.201.491621
http://spunk.dnsalias.org
http://www.linuxdj.com/audio/lad/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

From: Robert Thompson <rothomp3@vt.edu>
To: Franz Sirl <Franz.Sirl@munich.netsurf.de>
Subject: Re: trackpad and 2.2.17prex-ben1
Date: Sat, 8 Jul 2000 07:45:22 -0400
Content-Type: text/plain
Cc: linuxppc-dev@lists.linuxppc.org, bh40@calva.net
References: <4.3.2.7.2.20000707230217.00c1e280@mail.munich.netsurf.de>
In-Reply-To: <4.3.2.7.2.20000707230217.00c1e280@mail.munich.netsurf.de>
MIME-Version: 1.0
Message-Id: <00070807530600.08702@rothomp3>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 07 Jul 2000, Franz Sirl wrote:
>Did you change any config options from Ben's default in .config? Please
>make sure you enabled the options described at the top
>of  <http://homepages.munich.netsurf.de/Franz.Sirl/inputppc.html>.
>
Hmmm... well, I have all those options enabled, but it didn't help any. dmesg
shows that the trackpad is found and initialized, etc, but it just doesn't
work! Xpmac doesn't use it, and I tried numerous gpm lines trying to get it to
work, to no avail. dmesg reports that it's mouse3, so I even tried
gpm -m /dev/input/mouse3 -t imps2: results in no function
gpm -m /dev/input/mouse3 -t bm: results in no function
gpm -m /dev/mouse -t imps2: external USB trackball works great, but still no
trackpad
etc, etc. Yes, I did kill each gpm process before testing the next
one... Since I do own a USB trackball, and prefer using it (two buttons and
all, you know) this isn't a showstopper for me, but it is kind of annoying...

Finally, on another topic (while I'm writing): I feel kinda guilty asking about
all this, since I'm not contributing code (my C skills are small and my
assembly and hardware skills are non-existent), but... I was wondering about
power management and sound. Any status updates on those?

Thanks,
Robbie Thompson
--
Help Crack RC5! ---> http://www.ccc.vt.edu

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

From: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
To: Paul Mackerras <paulus@linuxcare.com>,
        Linux/PPC Developer list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: adb_buttons kernel argument
Date: Wed, 29 Mar 2000 21:32:01 +0200
Content-Type: text/plain
References: <00032911415300.05568@argo.linuxcare.com.au>
In-Reply-To: <00032911415300.05568@argo.linuxcare.com.au>
MIME-Version: 1.0
Message-Id: <00032921380900.03866@enzo.bigblue.local>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Am Wed, 29 Mar 2000 schrieb Paul Mackerras:
>I have just realized that with 2.3.xx (since 2.3.18) the format of the
>arguments for the adb_buttons=xxx kernel command-line argument has
>changed.  With 2.2 you can say adb_buttons=1 to emulate buttons 2 and 3
>with the right control and option keys, or you can say adb_buttons=xx,yy
>to use keycodes xx and yy to emulate buttons 2 and 3.  With 2.3 you now
>have to say adb_buttons=1,xx,yy.
>
>I propose to change 2.3 back to the 2.2 behaviour since that is what is
>documented.  Does anybody have any problem with that?

Well, change the documentation. I think somebody is integrating my xpmac-style
adb_buttons support and so there will be a adb_buttons=2,xx,yy soon. I think
the old syntax was a little bit strange anyway and probably was only a mistake
and no intended behaviour.

Franz.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

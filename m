In-Reply-To: <Pine.SOL.3.95.1000307220928.20594A-100000@juliet>
Date: Wed, 8 Mar 2000 10:53:56 +0100
To: Derek Homeier <supas100@astrophysik.uni-kiel.de>,
        linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: 2.2.15pre11 on PB Lombard
Message-Id: <20000308105356.021134@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Mar 7, 2000, Derek Homeier <supas100@astrophysik.uni-kiel.de> wrote:

>... some 2^4 adresses or so follow, which I could write down if anyone
>will find them useful. I can't get anything beyond that, because xmon
>prints everything else black on black!
>
>This happens both with CONFIG_MAC_FLOPPY set or unset (the above is without
>floppy driver)

Check that you didn't include inadvertently the legacy PC floppy driver


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

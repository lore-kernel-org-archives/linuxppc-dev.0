Date: Tue, 31 Oct 2000 02:39:14 +1100
From: Chris Leishman <chris@sharinga.com>
To: Paul Mackerras <paulus@linuxcare.com.au>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.2.18-pre17 candidate
Message-ID: <20001031023914.B364@nina.dev.fol>
References: <14837.11341.207379.903189@argo.linuxcare.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <14837.11341.207379.903189@argo.linuxcare.com.au>; from paulus@linuxcare.com.au on Tue, Oct 24, 2000 at 05:29:33PM +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Oct 24, 2000 at 05:29:33PM +1100, Paul Mackerras wrote:
<snip>
> I'll be interested to hear how people go with it.  I'll check the
> changes into the bitkeeper linuxppc_2_2 tree within the next day or
> so.  If it goes OK I'll send the patch to Alan for inclusion in
> 2.2.18.
>
> Paul.

If you compile the GMAC driver as a module it complains about an unresolvable
symbol "feature_set_gmac_phy_reset".  This is a symbol in the matching kernel,
so I'm not sure whats going on...

Also, when I tried using the new input stuff my mapping of right/middle mouse
buttons to F9 and F10 (use append="adb_buttons=101,109" in yaboot) stopped
working.

Chris

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

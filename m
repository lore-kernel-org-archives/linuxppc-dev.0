Date: Tue, 30 Mar 1999 23:51:39 -0700
From: Cort Dougan <cort@ppc.kernel.org>
To: Benjamin Herrenschmidt <bh40@calva.net>
Cc: linuxppc-dev@lists.linuxppc.org, Cort Dougan <cort@ppc.kernel.org>
Subject: Re: Yesterday vger and ioremap
Message-ID: <19990330235139.A9072@persephone.ppc.kernel.org>
References: <19990330035423.A6273@persephone.ppc.kernel.org> <19990330125854.000150@mail.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <19990330125854.000150@mail.mipsys.com>; from Benjamin Herrenschmidt on Tue, Mar 30, 1999 at 12:58:54PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


The ioremap problems should be fixed now.  Please try it again.  If it
isn't fixed let me know.

} vger tree from yesterday gives me tons of warnings of the style:
} "__ioremap(). Overlap detected and handled for PA xxxxxxx VA xxxxxxxx"
} when booting.

Those were just debugging messages until the ioremap changes were done.

} (I didn't look at actual source code changes, the problem seems to be
} harmless, just those messages in the console).

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]

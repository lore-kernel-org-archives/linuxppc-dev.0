Date: Wed, 3 Oct 2001 14:48:05 -0600
From: Cort Dougan <cort@fsmlabs.com>
To: "Jeffrey D. Kowing" <jeffrey.d.kowing1@jsc.nasa.gov>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: What is hex num for in progress messages ?
Message-ID: <20011003144805.D12102@ftsoj.fsmlabs.com>
References: <15291.26679.248183.187604@igor.jsc.nasa.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <15291.26679.248183.187604@igor.jsc.nasa.gov>; from jeffrey.d.kowing1@jsc.nasa.gov on Wed, Oct 03, 2001 at 02:34:15PM -0500
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I orginally added the progress mechanism for the IBM RS/6000's.  Some have
a LCD display (the progress messages appear there) and som others only had
a panel with 4 7-segment LED displays.  The numbers are supposed to be
unique to each message so it's possible to look the message up.

} Please forgive my ignorance, but for sometime I've been wondering what
} that hex number passed to the ppc_md.progress function is for.  Do
} certain debuggers like xmon use it?
}
} Thanks,
} Jeff Kowing
}
} --
} Jeff Kowing
} jeffrey.d.kowing1@jsc.nasa.gov
}

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

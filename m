Date: Thu, 21 Dec 2000 12:45:17 -0700
From: Cort Dougan <cort@fsmlabs.com>
To: Rabeeh Khoury <rabeeh@galileo.co.il>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: heartbeat functions
Message-ID: <20001221124517.J28231@hq.fsmlabs.com>
References: <3A41E015.4060202@galileo.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3A41E015.4060202@galileo.co.il>; from Rabeeh Khoury on Thu, Dec 21, 2000 at 12:48:53PM +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


}
} Hi,
}
} I'm porting Linux to our embedded ppc board.
} Can any one point me to documentation regarding the following function
} and parameters ?
}
}    ppc_md.heartbeat
}    ppc_md.heartbeat_reset
}    ppc_md.heartbeat_count
}
} What they are used to ?

No documentation, but heartbeat is the function to call when the heartbeat
goes off, _count the heartbeat count and reset is how many timer ticks to
go before generating a call to the heartbeat.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

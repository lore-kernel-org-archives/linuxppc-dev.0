From: Cort Dougan <cort@fsmlabs.com>
Date: Thu, 20 Feb 2003 12:43:18 -0700
To: Chris Wedgwood <cw@f00f.org>
Cc: Paul Mackerras <paulus@samba.org>,
	Eugene Surovegin <ebs@ebshome.net>, brian.auld@adic.com,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: PowerMac vs. Intel for PowerPC Development Host
Message-ID: <20030220194318.GC9782@host109.fsmlabs.com>
References: <20030220010112.GB22880@f00f.org> <995FF289C9D69747A09E42992644595405B23678@penguin.adic.com> <20030220010112.GB22880@f00f.org> <5.1.0.14.2.20030219210505.037b67e8@mail.ebshome.net> <995FF289C9D69747A09E42992644595405B23678@penguin.adic.com> <20030220010112.GB22880@f00f.org> <15956.11756.925757.532452@argo.ozlabs.ibm.com> <20030220054534.GA24107@f00f.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20030220054534.GA24107@f00f.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Ah, if that's the case, another data point.  The 2.8 GHz dual P4, with
hyperthreading on (very important) and make -j 8 gives me a 1m 45s _devel
tree build for the ebony.  If the cache is warm it's faster but that's
with a cold buffer cache.

} I wasn't trying to compare fairly, mostly get the lowest possible
} compile time.
}
}
} On Wed, Feb 19, 2003 at 09:10:48PM -0800, Eugene Surovegin wrote:
}
} > I tried to compile the _same_ PPC kernel for one of boards (440GP
} > based).
}
} > Cross compiling on PIII 755Mhz running SuSE        - 16 min
} > Cross compiling on G4 PowerBook 1Ghz running YDL   - 6 min
}
} I don't have a PPC host to reasonably compare with, but a 440GP kernel
} (linuxppc_2_4_devel) for me builds in 3 minutes 29s (with gcc-2.95).
}
}
}
}    --cw
}

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
